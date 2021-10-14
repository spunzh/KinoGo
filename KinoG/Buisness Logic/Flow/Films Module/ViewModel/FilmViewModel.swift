// FilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

typealias IntHandler = (Int) -> (Void)

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData<[Film]>) -> Void)? { get set }
    var onDetails: IntHandler? { get set }
    func getFilms(type: Int)
}

final class FilmViewModel: FilmViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData<[Film]>) -> Void)?
    var onDetails: IntHandler?

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol?
    private let imageAPIService: ImageAPIServiceProtocol?

    // MARK: - Initialization

    init(networkService: MovieAPIServiceProtocol, imageService: ImageAPIServiceProtocol) {
        movieAPIService = networkService
        imageAPIService = imageService
    }

    // MARK: - Public Methods

    func getFilms(type: Int) {
        movieAPIService?.getFilms(type: type) { [weak self] results in
            switch results {
            case let .success(films):
                self?.updateViewData?(.success(films))
            case let .failure(error):
                self?.updateViewData?(.failure(error))
            }
        }
    }
}
