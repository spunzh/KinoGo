// KinoGUITests.swift
// Copyright © Spunzh. All rights reserved.

import XCTest

final class KinoGUITests: XCTestCase {
    var application: XCUIApplication!

    override func setUpWithError() throws {
        application = XCUIApplication()
        application.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testSegmentedControlFilmViewController() throws {
        let segmetedControll = application.segmentedControls

        let topRatedButton = segmetedControll.buttons.element(boundBy: 1)

        XCTAssertTrue(topRatedButton.exists)
        XCTAssertTrue(topRatedButton.isEnabled)
        topRatedButton.tap()

        let upcomingButton = segmetedControll.buttons.element(boundBy: 2)
        XCTAssertTrue(upcomingButton.exists)
        XCTAssertTrue(upcomingButton.isEnabled)

        upcomingButton.tap()

        let popularButton = segmetedControll.buttons.element(boundBy: 0)
        XCTAssertTrue(popularButton.exists)
        XCTAssertTrue(popularButton.isEnabled)

        popularButton.tap()
    }

    func testFilmsTableView() {
        let filmsTableView = application.tables["FilmsTableView"]

        XCTAssertTrue(filmsTableView.exists)
        XCTAssertTrue(filmsTableView.isEnabled)

        filmsTableView.swipeDown()
        filmsTableView.swipeUp()
    }

    func testFilmTableViewCell() {
        let filmsTableView = application.tables["FilmsTableView"]
        let filmCell = filmsTableView.cells["FilmsTableViewCell"]
        XCTAssertTrue(filmCell.exists)
        XCTAssertTrue(filmCell.firstMatch.isHittable)
        filmCell.firstMatch.tap()
    }

    func testDetailFilmTableView() {
        toDetailScreen()

        let detailFilmsTableView = application.tables["DetailFilmsTableView"]
        XCTAssertTrue(detailFilmsTableView.exists)
        XCTAssertTrue(detailFilmsTableView.isEnabled)

        detailFilmsTableView.swipeDown()
        detailFilmsTableView.swipeUp()
    }

    func testDetailFilmTableViewCell() {
        toDetailScreen()

        let detailFilmsTableView = application.tables["DetailFilmsTableView"]
        let detailCell = detailFilmsTableView.cells["DetailFilmsTableViewCell"]

        XCTAssertTrue(detailCell.exists)
    }

    func toDetailScreen() {
        let filmsTableView = application.tables["FilmsTableView"]
        let cell = filmsTableView.cells["FilmsTableViewCell"]

        cell.firstMatch.tap()
    }
}
