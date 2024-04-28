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
    
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()
    
    var onConfirm: (() -> Void)?
    var onCancel: (() -> Void)?
    
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
        
        secondTitleLabel.text = "Do you want to leave the game?"
        
        [confirmButton, cancelButton].forEach {
            $0.backgroundColor = .customBiege
            $0.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 24)
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        titleLabel.textColor = .customBlue
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        [titleLabel, secondTitleLabel, confirmButton, cancelButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        [titleLabel, secondTitleLabel, confirmButton, cancelButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            
            secondTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            secondTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            confirmButton.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 20),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configure(title: String, hiddenSecondTitle: Bool, confirmButtonTitle: String, cancelButtonTitle: String) {
        titleLabel.text = title
        secondTitleLabel.isHidden = hiddenSecondTitle
        confirmButton.setTitle(confirmButtonTitle, for: .normal)
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
    }
    
    @objc private func confirmTapped() {
        onConfirm?()
    }
    
    @objc private func cancelTapped() {
        onCancel?()
    }
}

