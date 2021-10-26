// FilmViewModel.swift
// Copyright © Spunzh. All rights reserved.

import Foundation

typealias IntHandler = (Int) -> (Void)

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData<[Film]>) -> Void)? { get set }
    var onDetails: IntHandler? { get set }
    func getFilms(type: FilmType)
    func loadImage(path: String, completion: @escaping (Data?) -> ())
}

final class FilmViewModel: FilmViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((FilmViewData<[Film]>) -> Void)?
    var onDetails: IntHandler?

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol?
    private let repository: Repository<Film>?
    private let proxy: ImageLoadingProtocol?

    // MARK: - Initialization

    init(
        networkService: MovieAPIServiceProtocol,
        repository: Repository<Film>,
        proxy: ImageLoadingProtocol
    ) {
        movieAPIService = networkService
        self.repository = repository
        self.proxy = proxy
        getFilms(type: FilmType.popular)
    }

    // MARK: - Public Methods

    func getFilms(type: FilmType) {
        if let films = repository?.get(type.rawValue), !films.isEmpty {
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

    func loadImage(path: String, completion: @escaping (Data?) -> ()) {
        proxy?.loadImage(url: path) { results in
            switch results {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
