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
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .customWhite
        layer.cornerRadius = 20
        clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 9
        
        secondTitleLabel.textColor = .customBlack
        secondTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        secondTitleLabel.numberOfLines = 0
        
        secondTitleLabel.text = "Your will lose all your progress"
        
        [topButton, bottomButton].forEach {
            $0.backgroundColor = .customBiege
            $0.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 24)
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        titleLabel.textColor = .customBlue
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
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
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            
            secondTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            secondTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            topButton.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 20),
            topButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            topButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            topButton.heightAnchor.constraint(equalToConstant: 50),
            
            bottomButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 10),
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

