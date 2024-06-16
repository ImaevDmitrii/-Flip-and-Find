//
//  SaveButton.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import UIKit

final class SaveButton: UICollectionReusableView {
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .customBiege
        button.setTitle(Localization.save, for: .normal)
        button.titleLabel?.font = .buttonFont
        button.setTitleColor(.customBlack, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(saveButton)
        
        let padding: CGFloat = 16
        let spacing: CGFloat = 20
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
