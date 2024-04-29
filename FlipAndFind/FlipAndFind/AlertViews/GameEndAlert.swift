//
//  GameEndAlert.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 28.04.2024.
//

import UIKit

final class GameEndAlert: UIView {
    
    private let titleLabel = UILabel()
    private let themeLabel = UILabel()
    private let cardCountLabel = UILabel()
    private let textTimeLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let cardIcon = UIImageView(image: UIImage(named: "card_icon"))
    private let clockIcon = UIImageView(image: UIImage(named: "clock_icon"))
    
    private let rightMedalIcon = UIImageView(image: UIImage(named: "medal_icon"))
    private let leftMedalIcon = UIImageView(image: UIImage(named: "medal_icon"))
    
    private let playButton = UIButton()
    private let backButton = UIButton()
    
    var onPlayAgain: (() -> Void)?
    var onBackToMenu: (() -> Void)?
    
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
        
        [themeLabel, cardCountLabel, textTimeLabel].forEach {
            $0.textColor = .customBlack
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
        }
        
        [cardIcon, clockIcon].forEach {
            $0.widthAnchor.constraint(equalToConstant: 16).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 16).isActive = true
        }
        
        [leftMedalIcon, rightMedalIcon].forEach {
            $0.contentMode = .scaleAspectFit
        }
        
        [playButton, backButton].forEach {
            $0.backgroundColor = .customBiege
            $0.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 24)
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        playButton.setTitle("Play again", for: .normal)
        backButton.setTitle("Back to menu", for: .normal)
        
        playButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backToMenuTapped), for: .touchUpInside)
        
        textTimeLabel.text = "Your Time"
        
        titleLabel.textColor = .customBlue
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        timeLabel.textColor = .customBlack
        
        [titleLabel, themeLabel, cardCountLabel, textTimeLabel, timeLabel, cardIcon, clockIcon, rightMedalIcon, leftMedalIcon, playButton, backButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        [titleLabel, themeLabel, cardCountLabel, textTimeLabel, timeLabel, cardIcon, clockIcon, rightMedalIcon, leftMedalIcon, playButton, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            leftMedalIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            leftMedalIcon.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8),
            leftMedalIcon.widthAnchor.constraint(equalToConstant: 30),
            leftMedalIcon.heightAnchor.constraint(equalToConstant: 30),
            
            rightMedalIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            rightMedalIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            rightMedalIcon.widthAnchor.constraint(equalToConstant: 30),
            rightMedalIcon.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            
            themeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            themeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            cardCountLabel.centerYAnchor.constraint(equalTo: themeLabel.centerYAnchor),
            cardCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            cardIcon.centerYAnchor.constraint(equalTo: cardCountLabel.centerYAnchor),
            cardIcon.trailingAnchor.constraint(equalTo: cardCountLabel.leadingAnchor, constant: -8),
            
            textTimeLabel.topAnchor.constraint(equalTo: cardIcon.bottomAnchor, constant: 20),
            textTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            timeLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            
            clockIcon.centerYAnchor.constraint(equalTo: textTimeLabel.bottomAnchor, constant: 20),
            clockIcon.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            clockIcon.widthAnchor.constraint(equalToConstant: 20),
            clockIcon.heightAnchor.constraint(equalToConstant: 20),
            
            playButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configure(title: String, theme: String, cardCount: Int, time: String) {
        titleLabel.text = title
        themeLabel.text = theme
        cardCountLabel.text = "\(cardCount) cards"
        timeLabel.text = time
    }
    
    @objc private func playAgainTapped() {
        onPlayAgain?()
    }
    
    @objc private func backToMenuTapped() {
        onBackToMenu?()
    }
}
