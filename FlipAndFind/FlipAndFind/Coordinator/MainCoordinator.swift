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
        navigationController.setupNavigationBar()
    }
    
    func start() {
        let mainController = MainViewController()
        mainController.coordinator = self
        navigationController.pushViewController(mainController, animated: true)
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


