// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RepositoryProtocol {
    associatedtype Entity

    func save(_ data: [Entity])
    func get(_ type: FilmType) -> [Entity]?
}

//
class Repository<DataBaseEntity>: RepositoryProtocol {
    typealias Entity = DataBaseEntity

    func save(_ data: [Entity]) {
        fatalError("save(_ data: must be overrided")
    }

    func get(_ type: FilmType) -> [Entity]? {
        fatalError("get(_ type: must be overrided")
    }
}
