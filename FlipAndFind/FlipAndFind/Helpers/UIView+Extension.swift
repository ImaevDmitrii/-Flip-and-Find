//
//  UIView+EXtension.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 14.05.2024.
//

import UIKit

extension UIView {
    func applyAlertStyle() {
        backgroundColor = .customWhite
        layer.cornerRadius = 20
        clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 9
    }
}
