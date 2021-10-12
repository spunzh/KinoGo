//
//  FilmViewModel.swift
//  KinoG
//
//  Created by Мажит Закиров on 12.10.2021.
//

import Foundation

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData) -> Void)? { get set }
    var films: [FilmViewData.Results] { get set }
    func getFilms(type: Int)
}

final class FilmViewModel: FilmViewModelProtocol {
    private let filmService = FilmService()
    var updateViewData: ((FilmViewData) -> Void)?

    var films: [FilmViewData.Results] = []

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
