// FilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData<[Film], Error>) -> Void)? { get set }
    func getFilms(type: Int)
}

final class FilmViewModel: FilmViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData<[Film], Error>) -> Void)?

    // MARK: - Private Properties

    private let filmService = MovieAPIService()

    // MARK: - Public Methods

    func getFilms(type: Int) {
        filmService.getFilms(type: type) { [weak self] results in
            switch results {
            case let .success(films):
                self?.updateViewData?(.success(films))
            case let .failure(error):
                self?.updateViewData?(.failure(error))
            }
        }
    }
}
