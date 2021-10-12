//
//  FilmViewModel.swift
//  KinoG
//
//  Created by Мажит Закиров on 12.10.2021.
//

import Foundation

protocol FilmViewModelProtocol {
    var updateViewData: ((FilmViewData) -> Void)? { get set }
    func getFilms(type: Int)
}

final class FilmViewModel: FilmViewModelProtocol {
    private let filmService = FilmService()
    var updateViewData: ((FilmViewData) -> Void)?

    func getFilms(type: Int) {
        filmService.getFilms(type: type) { [weak self] result in
            switch result {
            case let .success(films):
                self?.updateViewData?(.success(films))
            case let .failure(error):
                self?.updateViewData?(.failure(error))
            }
        }
    }
}
