//
//  SceneDelegate.swift
//  MusicApp
//
//  Created by Default on 10.05.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            let navigation = UINavigationController(rootViewController: ViewController())
            window?.rootViewController = navigation
            window?.makeKeyAndVisible()
        }
}

