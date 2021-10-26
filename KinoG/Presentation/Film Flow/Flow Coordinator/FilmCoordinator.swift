// FilmCoordinator.swift
// Copyright © Spunzh. All rights reserved.

import Foundation
import UIKit

final class FilmCoordinator: NSObject, Coordinator {
    var navigationControler: UINavigationController?
    var childCoordinators: [Coordinator] = []

    func start() {
        guard let vc = AppAssemblerBuild.buildFilmModule() as? FilmsViewController else { return }
        vc.viewModel?.onDetails = { id in
            self.toFilmDetailsController(id: id)
        }

        navigationControler = UINavigationController(rootViewController: vc)
        guard let navigationControler = navigationControler else { return }
        setRoot(navigationControler)
    }

    private func toFilmDetailsController(id: Int) {
        let vc = AppAssemblerBuild.buildFilmsDetailsModule(id: id)
        navigationControler?.pushViewController(vc, animated: true)
    }
}
