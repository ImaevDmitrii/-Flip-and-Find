//
//  UIImage+Extension.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.05.2024.
//

import UIKit

extension UIImage {
    func scaleToSize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
