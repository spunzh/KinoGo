// RealmDBService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

final class RealmDBService<RealmEntity: Object>: Repository<RealmEntity> {
    typealias Entity = RealmEntity

    override func get(_ type: String) -> [Entity]? {
        let predicate = NSPredicate(format: "type == %@", type)
        do {
            let realm = try Realm()
            let objects = realm.objects(Entity.self).filter(predicate)

            var sortedObjects: [Entity] = []
            objects.forEach { sortedObjects.append($0) }

            return sortedObjects

        } catch {
            print(error)
        }

        return nil
    }

    override func save(_ data: [Entity]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data, update: .modified)
            }

        } catch {
            print(error)
        }
    }
}
