// Assembly.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol AssemblyProtocol {
    static func buildFilmModule() -> UIViewController
    static func buildFilmsDetailsModule(id: Int) -> UIViewController
}

final class AssemblerBuild: AssemblyProtocol {
    static func buildFilmModule() -> UIViewController {
        let movieAPIService = MovieAPIService()
        let imageAPIService = ImageAPIService()
        let viewModel = FilmViewModel(
            networkService: movieAPIService,
            imageService: imageAPIService
        )
        let vc = FilmsViewController()
        vc.viewModel = viewModel

        return vc
    }

    static func buildFilmsDetailsModule(id: Int) -> UIViewController {
        let movieAPIService = MovieAPIService()
        let imageAPIService = ImageAPIService()
        let viewModel = FilmDetailsViewModel(
            filmID: id,
            networkService: movieAPIService,
            imageService: imageAPIService
        )
        let vc = FilmDetailsViewController()
        vc.viewModel = viewModel

        return vc
    }
}
