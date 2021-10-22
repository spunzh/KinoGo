// FilmDetailsViewModelTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import KinoG
import XCTest

final class MockDetailsAPIService: MovieAPIServiceProtocol {
    var filmResults: Film!

    init() {}

    convenience init(filmResults: Film?) {
        self.init()
        self.filmResults = filmResults
    }

    func getFilms(type: FilmType, complition: @escaping (Result<[Film], Error>) -> Void) {}

    func getFilmDetails(filmID: Int, complition: @escaping (Result<Film, Error>) -> Void) {
        if let filmResults = filmResults {
            complition(.success(filmResults))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            complition(.failure(error))
        }
    }
}

final class MockDetailsRepository<Entity>: Repository<Entity> {
    typealias Entity = Entity

    var modelEntity: [Entity] = []

    override func save(_ data: [Entity]) {
        modelEntity.append(contentsOf: data)
    }

    override func get(_ type: String) -> [Entity]? {
        modelEntity
    }
}

final class MockProxyImage: ImageLoadingProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ()) {}
}

final class DetailsViewModelTests: XCTestCase {
    let expectationText = "Test UpdateViewDetails"
    var detailsViewModel: FilmDetailsViewModel!
    var mockDetailsAPIService: MockDetailsAPIService!
    var proxy: MockProxyImage!
    var mockDetailsRepository: MockDetailsRepository<Film>!

    override func setUp() {
        proxy = MockProxyImage()
        mockDetailsRepository = MockDetailsRepository<Film>()
    }

    override func tearDown() {
        detailsViewModel = nil
        mockDetailsAPIService = nil
        mockDetailsRepository = nil
    }

    func testGetSuccesDetails() {
        let fakeFilmDetails = Film()

        mockDetailsAPIService = MockDetailsAPIService(filmResults: fakeFilmDetails)
        detailsViewModel = FilmDetailsViewModel(
            filmID: 0,
            networkService: mockDetailsAPIService,
            proxy: proxy
        )

        var catchDetails: Film?
        mockDetailsAPIService.getFilmDetails(filmID: 0) { result in
            switch result {
            case let .success(movie):
                catchDetails = movie
            case let .failure(error):
                print(error)
            }
        }
        XCTAssertEqual(catchDetails, fakeFilmDetails)
    }

    func testGetFailureDetails() {
        let fakeFilmDetails: Film? = nil

        mockDetailsAPIService = MockDetailsAPIService(filmResults: fakeFilmDetails)
        detailsViewModel = FilmDetailsViewModel(
            filmID: 0,
            networkService: mockDetailsAPIService,
            proxy: proxy
        )

        var catchError: Error?

        mockDetailsAPIService.getFilmDetails(filmID: 0) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }

    func testUpdateViewDetails() {
        let fakeFilmDetails = Film()
        let expectation = XCTestExpectation(description: expectationText)
        mockDetailsAPIService = MockDetailsAPIService(filmResults: fakeFilmDetails)
        detailsViewModel = FilmDetailsViewModel(
            filmID: 0,
            networkService: mockDetailsAPIService,
            proxy: proxy
        )

        mockDetailsRepository.save([fakeFilmDetails])

        detailsViewModel.updateViewData = { viewData in
            var catchFilmDetails: Film?
            if case let .success(movie) = viewData {
                catchFilmDetails = movie
            }
            XCTAssertTrue(catchFilmDetails == fakeFilmDetails)
            expectation.fulfill()
        }

        detailsViewModel.getFilmDetails()

        wait(for: [expectation], timeout: 5.0)
    }
}
