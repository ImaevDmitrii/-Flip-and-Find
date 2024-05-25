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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupShadowAndRadius()
        
        imageView.contentMode = .scaleAspectFit
        
        label.textAlignment = .center
        label.font = .bodyText
        label.textColor = .customBlack
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        [imageView, label].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupShadowAndRadius() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.4
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    func configure(with imageName: String, isSelected: Bool, text: String) {
        imageView.image = UIImage(named: isSelected ? imageName + "_choosen" : imageName)
        
        label.text = text
    }
}
