//
//  SceneDelegate.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 05.04.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let launchVC = LaunchAnimationViewController()
        launchVC.completionHandler = { [weak self] in
            self?.showMainScreen()
        }
        window?.rootViewController = launchVC
        
        
        window?.makeKeyAndVisible()
    }
    
    private func showMainScreen() {
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window?.rootViewController = navigationController
    }
}

