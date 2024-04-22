//
//  NavigationBar+Extension.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import UIKit

extension UINavigationController {
    func setupNavigationBar() {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = .customBlue
        
        appearence.titleTextAttributes = [.foregroundColor: UIColor.customWhite, .font: UIFont(name: "Montserrat-SemiBold", size: 24) ?? UIFont.systemFont(ofSize: 24)]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.customWhite, .font: UIFont(name: "Montserrat-SemiBold", size: 34) ?? UIFont.systemFont(ofSize: 34)]
        
        navigationBar.layer.cornerRadius = 50
        navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        navigationBar.layer.masksToBounds = true
        navigationBar.standardAppearance = appearence
        navigationBar.compactAppearance = appearence
        navigationBar.scrollEdgeAppearance = appearence
        navigationBar.tintColor = .customWhite
    }
}
