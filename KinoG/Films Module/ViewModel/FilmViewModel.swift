// FilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData) -> Void)? { get set }
    var films: [FilmViewData.Results] { get set }
    func getFilms(type: Int)
}

final class FilmViewModel: FilmViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData) -> Void)?
    var films: [FilmViewData.Results] = []

    // MARK: - Private Properties

    private let filmService = FilmService()

    // MARK: - Public Methods

    func getFilms(type: Int) {
        filmService.getFilms(type: type) { [weak self] result in
            switch result {
            case .reload: break
            case let .success(films):
                self?.films = films
                self?.updateViewData?(.reload)
            case let .failure(error):
                self?.updateViewData?(.failure(error))
            }
        }
    }
}
