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
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
