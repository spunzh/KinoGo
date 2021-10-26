// FilmViewModelTests.swift
// Copyright © Spunzh. All rights reserved.

@testable import KinoG
import XCTest

final class MockFilmAPIService: MovieAPIServiceProtocol {
    var filmResults: [Film]!

    init() {}

    convenience init(filmResults: [Film]?) {
        self.init()
        self.filmResults = filmResults
    }

    func getFilms(type: FilmType, complition: @escaping (Result<[Film], Error>) -> Void) {
        if let filmResults = filmResults {
            complition(.success(filmResults))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            complition(.failure(error))
        }
    }

    func getFilmDetails(filmID: Int, complition: @escaping (Result<Film, Error>) -> Void) {}
}

final class MockFilmRepository<Entity>: Repository<Entity> {
    typealias Entity = Entity

    var modelEntity: [Entity] = []

    override func save(_ data: [Entity]) {
        modelEntity.append(contentsOf: data)
    }

    override func get(_ type: String) -> [Entity]? {
        modelEntity
    }
}

final class MockFilmProxyImage: ImageLoadingProtocol {
    func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> ()) {}
}

final class FilmViewModelTests: XCTestCase {
    let expectationText = "Test UpdateViewDetails"
    var filmsViewModel: FilmViewModel!
    var mockFilmAPIService: MockFilmAPIService!
    var proxy: MockProxyImage!
    var mockFilmRepository: MockFilmRepository<Film>!

    override func setUp() {
        proxy = MockProxyImage()
        mockFilmRepository = MockFilmRepository<Film>()
    }

    override func tearDown() {
        filmsViewModel = nil
        mockFilmAPIService = nil
        mockFilmRepository = nil
    }

    func testGetSuccesDetails() {
        let fakeFilms: [Film] = []

        mockFilmAPIService = MockFilmAPIService(filmResults: fakeFilms)
        filmsViewModel = FilmViewModel(
            networkService: mockFilmAPIService,
            repository: mockFilmRepository,
            proxy: proxy
        )

        var catchDetails: [Film]?
        mockFilmAPIService.getFilms(type: FilmType.popular) { result in
            switch result {
            case let .success(movie):
                catchDetails = movie
            case let .failure(error):
                print(error)
            }
        }
        XCTAssertEqual(catchDetails, fakeFilms)
    }

    func testGetFailureDetails() {
        let fakeFilms: [Film]? = nil

        mockFilmAPIService = MockFilmAPIService(filmResults: fakeFilms)
        filmsViewModel = FilmViewModel(
            networkService: mockFilmAPIService,
            repository: mockFilmRepository,
            proxy: proxy
        )

        var catchError: Error?

        mockFilmAPIService.getFilms(type: FilmType.popular) { result in
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
        let fakeFilms: [Film] = []
        let expectation = XCTestExpectation(description: expectationText)

        mockFilmAPIService = MockFilmAPIService(filmResults: fakeFilms)
        filmsViewModel = FilmViewModel(
            networkService: mockFilmAPIService,
            repository: mockFilmRepository,
            proxy: proxy
        )

        mockFilmRepository.save(fakeFilms)

        filmsViewModel.updateViewData = { viewData in
            var catchFilms: [Film]?
            if case let .success(movie) = viewData {
                catchFilms = movie
            }
            XCTAssertTrue(catchFilms == fakeFilms)
            expectation.fulfill()
        }

        filmsViewModel.getFilms(type: FilmType.popular)

        wait(for: [expectation], timeout: 5.0)
    }
}
