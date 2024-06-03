//
//  MainCoordinator.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 14.04.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setupNavigationBar()
    }
    
    func start() {
        let launchVC = LaunchAnimationViewController()
        launchVC.completionHandler = { [weak self] in
            self?.showMainMenu()
        }
        navigationController.setViewControllers([launchVC], animated: false)
    }
    
   private func showMainMenu() {
        let mainController = MainViewController()
        mainController.coordinator = self
        navigationController.setViewControllers([mainController], animated: false)
    }
    
    func startGame() {
        let gameViewController = GameCollectionViewController()
        navigationController.pushViewController(gameViewController, animated: true)
    }
    
    func showMyGames() {
        let resultsViewController = ResultsTableViewController()
        navigationController.pushViewController(resultsViewController, animated: true)
    }
    
    func showSettings() {
        let settingsViewController = SettingsCollectionViewController()
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}


