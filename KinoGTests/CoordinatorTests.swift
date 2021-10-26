// CoordinatorTests.swift
// Copyright © Spunzh. All rights reserved.

@testable import KinoG
import XCTest

final class MockViewController: UIViewController {}

final class CoordinatorTests: XCTestCase {
    var coordinator: Coordinator!

    override func setUpWithError() throws {
        coordinator = FilmCoordinator()
    }

    override func tearDownWithError() throws {
        coordinator = nil
    }

    func testAddDependencySuccess() throws {
        coordinator.addDependency(coordinator)
        XCTAssertTrue(coordinator.childCoordinators.first is FilmCoordinator)
    }

    func testAddDependencySameCoordinatorSuccess() throws {
        coordinator.addDependency(coordinator)
        coordinator.addDependency(coordinator)

        XCTAssertEqual(coordinator.childCoordinators.count, 1)
    }

    func testRemoveDependencySuccess() throws {
        coordinator.addDependency(coordinator)
        coordinator.removeDependency(coordinator)

        XCTAssertTrue(coordinator.childCoordinators.isEmpty)
    }

    func testSetRootSucces() throws {
        let controller = MockViewController()
        coordinator.setRoot(controller)

        XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController is MockViewController)
    }
}
