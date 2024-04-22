//
//  MainCoordinator.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 14.04.2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainController = MainViewController()
        navigationController.pushViewController(mainController, animated: true)
    }
    
    func startGame() {
        let gameViewController = MainViewController()
        navigationController.pushViewController(gameViewController, animated: true)
    }
    
    func showMyGames() {
        let resultsViewController = MainViewController()
        navigationController.pushViewController(resultsViewController, animated: true)
    }
    
    func showSettings() {
        let settingsViewController = SettingsCollectionViewController()
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}


