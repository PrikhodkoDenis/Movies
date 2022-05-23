//
//  FetchError.swift
//  Movies
//
//  Created by Denis on 15.05.2022.
//

import Foundation

enum FetchError: Error {
    case other
    case parse
    case isNotConnected
    case endFreeRequests
    
    var message: String {
        switch self {
        case .other:
            return "Что-то пошло не так"
        case .parse:
            return "Получены некорректные данные"
        case .isNotConnected:
            return "Нет соединения с интернетом"
        case .endFreeRequests:
            return "Закончились бесплатные запросы на сервер"
        }
    }
}
