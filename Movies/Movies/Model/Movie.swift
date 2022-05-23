//
//  Movie.swift
//  Movies
//
//  Created by Denis on 15.05.2022.
//

struct Movie: Decodable, Hashable {
    let items: [Film]
    let errorMessage: String
}




