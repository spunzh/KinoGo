// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class ApplicationCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationControler: UINavigationController?

    func start() {
        toMain()
    }

    func toMain() {
        let coordinator = FilmCoordinator()

        addDependency(coordinator)
        coordinator.start()
    }
}
