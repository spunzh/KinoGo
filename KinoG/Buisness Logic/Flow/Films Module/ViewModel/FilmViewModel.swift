// FilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

typealias IntHandler = (Int) -> (Void)

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData<[Film]>) -> Void)? { get set }
    var onDetails: IntHandler? { get set }
    func getFilms(type: FilmType)
}

final class FilmViewModel: FilmViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData<[Film]>) -> Void)?
    var onDetails: IntHandler?

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol?
    private let imageAPIService: ImageAPIServiceProtocol?
    private let repository: Repository<Film>?

    // MARK: - Initialization

    init(networkService: MovieAPIServiceProtocol, imageService: ImageAPIServiceProtocol, repository: Repository<Film>) {
        movieAPIService = networkService
        imageAPIService = imageService
        self.repository = repository
        getFilms(type: FilmType.popular)
    }

    // MARK: - Public Methods

    func getFilms(type: FilmType) {
        if let films = repository?.get(type), !films.isEmpty {
            updateViewData?(.success(films))
        } else {
            movieAPIService?.getFilms(type: type) { [weak self] results in
                switch results {
                case let .success(films):
                    DispatchQueue.main.async {
                        self?.repository?.save(films)
                    }
                    self?.updateViewData?(.success(films))
                case let .failure(error):
                    self?.updateViewData?(.failure(error))
                }
            }
        }
    }
}
