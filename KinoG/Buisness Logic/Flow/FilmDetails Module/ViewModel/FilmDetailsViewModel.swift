// FilmDetailsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol FilmDetailsViewModelProtocol {
    var updateViewData: ((FilmViewData<Film, Error>) -> Void)? { get set }
    var filmID: Int? { get set }
    func getFilmDetails()
    func loadImage(path: String, completion: @escaping (Data?) -> ())
}

final class FilmDetailsViewModel: FilmDetailsViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData<Film, Error>) -> Void)?
    var filmID: Int?

    // MARK: - Initialization

    init(filmID: Int) {
        self.filmID = filmID
        getFilmDetails()
    }

    // MARK: - Private Properties

    private let movieAPIService = MovieAPIService()
    private let imageAPIService = ImageAPIService()

    // MARK: - Public Methods

    func getFilmDetails() {
        guard let filmID = filmID else { return }

        movieAPIService.getFilmDetails(filmID: filmID) { [weak self] result in
            switch result {
            case let .success(film):
                self?.updateViewData?(.success(film))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func loadImage(path: String, completion: @escaping (Data?) -> ()) {
        imageAPIService.loadImage(url: path) { results in
            switch results {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
