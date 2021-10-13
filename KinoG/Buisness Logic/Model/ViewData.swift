// ViewData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// FilmViewData
enum FilmViewData<Success, Failure> where Failure: Error {
    case initial
    case success(Success)
    case failure(Failure)
}

///
struct Objects: Decodable {
    /// Фильмы
    let results: [Film]
}

/// Фильм
struct Film: Decodable {
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