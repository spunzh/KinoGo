// ViewData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

// FilmViewData
enum FilmViewData<Success> {
    case initial
    case success(Success)
    case failure(Error)
}

///
struct Objects: Decodable {
    /// Фильмы
    let results: [Film]
}

/// Фильм
final class Film: Object, Decodable {
    /// Айди
    @objc dynamic var id: Int
    /// Название
    @objc dynamic var title: String
    /// Дата релиза
    @objc dynamic var releaseDate: String
    /// Описание
    @objc dynamic var overview: String
    /// Путь к картинке постера
    @objc dynamic var posterPath: String

    @objc dynamic var type: String?

    override class func primaryKey() -> String? {
        "id"
    }
}
