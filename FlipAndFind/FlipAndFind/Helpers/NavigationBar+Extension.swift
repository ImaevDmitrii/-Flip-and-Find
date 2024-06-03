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
        
        appearence.titleTextAttributes = [.foregroundColor: UIColor.customWhite, .font: .secondHeader ?? UIFont.systemFont(ofSize: 24)]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.customWhite, .font: .largeSecondHeader ?? UIFont.systemFont(ofSize: 34)]
        
        appearence.shadowColor = nil
        
        navigationBar.standardAppearance = appearence
        navigationBar.compactAppearance = appearence
        navigationBar.scrollEdgeAppearance = appearence
        navigationBar.tintColor = .customWhite
        
        navigationBar.layer.masksToBounds = false
        navigationBar.isTranslucent = false
    }
    
    func setupBackButton(action: Selector, target: Any?) {
        let arrowBackImage = UIImage(systemName: "arrow.left")
        let scaledImage = arrowBackImage?.scaleToSize(size: CGSize(width: 34, height: 24))
        let backItem = UIBarButtonItem(image: scaledImage, style: .plain, target: target, action: action)
        topViewController?.navigationItem.leftBarButtonItem = backItem
    }
}

