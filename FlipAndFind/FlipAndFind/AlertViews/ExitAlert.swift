//
//  ExitAlert.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 28.04.2024.
//

import UIKit

final class ExitAlert: UIView {
    
    private let titleLabel = UILabel()
    private let secondTitleLabel = UILabel()
    
    private let topButton = UIButton()
    private let bottomButton = UIButton()
    
    var onTopButton: (() -> Void)?
    var onBottomButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        applyAlertStyle()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if secondTitleLabel.isHidden {
            NSLayoutConstraint.activate([
                topButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
            ])
        } else {
            NSLayoutConstraint.activate([
                topButton.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 20)
            ])
        }
    }
    
    private func setupViews() {
        secondTitleLabel.textColor = .customBlack
        secondTitleLabel.font = .bodyText
        secondTitleLabel.numberOfLines = 0
        
        secondTitleLabel.text = Localization.youWillLoseProgress
        secondTitleLabel.numberOfLines = 2
        
        [topButton, bottomButton].forEach {
            $0.backgroundColor = .customBiege
            $0.titleLabel?.font = .buttonFont
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        titleLabel.textColor = .customBlue
        titleLabel.font = .secondHeader
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        
        topButton.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        
        [titleLabel, secondTitleLabel, topButton, bottomButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        [titleLabel, secondTitleLabel, topButton, bottomButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            secondTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            secondTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            topButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            topButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            topButton.heightAnchor.constraint(equalToConstant: 50),
            
            bottomButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 15),
            bottomButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            bottomButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            bottomButton.heightAnchor.constraint(equalToConstant: 50),
            bottomButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configure(title: String, hiddenSecondTitle: Bool, confirmButtonTitle: String, cancelButtonTitle: String) {
        titleLabel.text = title
        secondTitleLabel.isHidden = hiddenSecondTitle
        topButton.setTitle(confirmButtonTitle, for: .normal)
        bottomButton.setTitle(cancelButtonTitle, for: .normal)
    }
    
    @objc private func topButtonTapped() {
        onTopButton?()
    }
    
    @objc private func bottomButtonTapped() {
        onBottomButton?()
    }
}

