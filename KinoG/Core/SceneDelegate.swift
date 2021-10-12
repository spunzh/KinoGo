// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let mainVC = FilmsViewController()
        mainVC.viewModel = FilmViewModel()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
