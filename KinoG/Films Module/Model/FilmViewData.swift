// FilmViewData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

enum FilmViewData {
    case success([Results])
    case failure(Error)

    struct Film: Decodable {
        /// Фильмы
        let results: [Results]
    }

    /// Фильм
    struct Results: Decodable {
        /// Айди
        let id: Int
        /// Название
        let title: String
        /// Дата релиза
        let releaseDate: String
        /// Описание
        let overview: String
        /// Путь к картинке постера
        let posterPath: String
    }
}
