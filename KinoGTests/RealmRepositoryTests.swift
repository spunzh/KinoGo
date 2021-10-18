// RealmRepositoryTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import KinoG
import RealmSwift
import XCTest

final class MockModel: Object, Decodable {
    @objc dynamic var type: String?

    @objc dynamic var id = Int()
    @objc dynamic var poster: String?
    @objc dynamic var overview = ""

    override class func primaryKey() -> String? {
        "id"
    }
}

final class RealmRepositoryTests: XCTestCase {
    let type = FilmType.popular.rawValue
    var realmRepository: RealmDBService<MockModel>!

    override func setUp() {
        realmRepository = RealmDBService()
    }

    override func tearDown() {
        realmRepository = nil
    }

    func testRealmSaveAndGet() {
        var fakeModels: [MockModel] = []
        let fakeModel = MockModel()
        fakeModel.type = type
        fakeModels.append(fakeModel)

        realmRepository.save(fakeModels)

        guard let catchModels = realmRepository.get(type) else { return }

        XCTAssertEqual(catchModels, fakeModels)
    }
}
