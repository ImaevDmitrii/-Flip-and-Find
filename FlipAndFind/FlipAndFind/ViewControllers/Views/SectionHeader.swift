//
//  SectionHeader.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 19.04.2024.
//

import UIKit

final class SectionHeader: UIView {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .secondHeader
        titleLabel.textColor = .darkGray
        addSubview(titleLabel)
        
        let padding: CGFloat = 16
        let size: CGFloat = 32
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
