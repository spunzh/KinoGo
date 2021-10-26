// AppAssembly.swift
// Copyright © Spunzh. All rights reserved.

import Foundation
import UIKit

protocol AssemblyProtocol {
    static func buildFilmModule() -> UIViewController
    static func buildFilmsDetailsModule(id: Int) -> UIViewController
}

final class AppAssemblerBuild: AssemblyProtocol {
    static func buildFilmModule() -> UIViewController {
        let movieAPIService = MovieAPIService()
        let imageAPIService = ImageAPIService()
        let cacheService = ImageCacheService()
        let proxy = ImageProxy(APIservice: imageAPIService, cacheService: cacheService)
        let repository = RealmDBService<Film>()
        let viewModel = FilmViewModel(
            networkService: movieAPIService,
            repository: repository,
            proxy: proxy
        )
        let vc = FilmsViewController()
        vc.viewModel = viewModel

        return vc
    }

    static func buildFilmsDetailsModule(id: Int) -> UIViewController {
        let movieAPIService = MovieAPIService()
        let imageAPIService = ImageAPIService()
        let cacheService = ImageCacheService()
        let proxy = ImageProxy(APIservice: imageAPIService, cacheService: cacheService)
        let viewModel = FilmDetailsViewModel(
            filmID: id,
            networkService: movieAPIService,
            proxy: proxy
        )
        let vc = FilmDetailsViewController()
        vc.viewModel = viewModel

        return vc
    }
}
