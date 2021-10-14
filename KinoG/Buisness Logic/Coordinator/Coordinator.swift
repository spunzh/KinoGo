// Coordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol Coordinator: NSObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationControler: UINavigationController? { get set }
    func addDependency(_ coordinator: Coordinator)
    func removeDependency(_ coordinator: Coordinator?)
    func start()
    func setRoot(_ controller: UIViewController)
}

extension Coordinator {
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator else { return }

        for (index, element) in childCoordinators.enumerated().reversed() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
