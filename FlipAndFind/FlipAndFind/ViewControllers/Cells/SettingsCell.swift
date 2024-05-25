//
//  SettingsCell.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 17.04.2024.
//

import UIKit

final class SettingsCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func addLabel() {
        contentView.addSubview(label)
        
        label.textAlignment = .center
        label.font = .bodyText
        label.textColor = .customBlack
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with imageName: String, isSelected: Bool, text: String? = nil) {
        imageView.image = UIImage(named: isSelected ? imageName + "_choosen" : imageName)
        
        label.text = text
    }
}
