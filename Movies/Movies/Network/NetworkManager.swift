//
//  NetworkManager.swift
//  Movies
//
//  Created by Denis on 15.05.2022.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let top250Url = "https://imdb-api.com/en/API/Top250Movies/k_295m5mni"
    private let detailedUrl = "https://imdb-api.com/en/API/Title/k_295m5mni/"
    
    func fetchMainData(completion: @escaping (_ result: Result<Movie, FetchError>) -> ()) {
        guard let url = URL(string: top250Url) else {
            completion(.failure(.other))
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if  let error = error {
                    let errorResult: FetchError = error.isNotConnected ? .isNotConnected : .other
                    completion(.failure(errorResult))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movie.self, from: data)
                        let errorMessage = movies.errorMessage 
                        guard errorMessage.isEmpty else {
                            return completion(.failure(.endFreeRequests))
                        }
                        completion(.success(movies))
                    } catch {
                        completion(.failure(.parse))
                    }
                }
            }.resume()
        }
    }
    
    func fetchDetailedData(filmId: String, completion: @escaping (_ result: Result<DetailedFilm, FetchError>) -> ()) {
        guard let url = URL(string: "\(detailedUrl)\(filmId)") else {
            completion(.failure(.other))
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if  let error = error {
                    let errorResult: FetchError = error.isNotConnected ? .isNotConnected : .other
                    completion(.failure(errorResult))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let detailedInfo = try decoder.decode(DetailedFilm.self, from: data)
                        completion(.success(detailedInfo))
                    } catch {
                        completion(.failure(.parse))
                    }
                }
            }.resume()
        }
    }
}
