// FilmDetailsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol FilmDetailsViewModelProtocol {
    var updateViewData: ((FilmViewData<Film, Error>) -> Void)? { get set }
    var filmID: Int? { get set }
    func getFilmDetails()
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

    private let filmService = MovieAPIService()

    // MARK: - Public Methods

    func getFilmDetails() {
        guard let filmID = filmID else { return }

        filmService.getFilmDetails(filmID: filmID) { [weak self] result in
            switch result {
            case let .success(film):
                self?.updateViewData?(.success(film))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
