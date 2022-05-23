//
//  Film.swift
//  Movies
//
//  Created by Denis on 22.05.2022.
//

struct Film: Decodable, Hashable {
    let id: String
    let year: String
    let title: String
    let image: String
}
