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
    
    private let timeStackView = UIStackView()
    
    private let cardIcon = UIImageView(image: UIImage(named: "card_icon"))
    private let clockIcon = UIImageView(image: UIImage(systemName: "timer"))
    
    private let rightMedalIcon = UIImageView(image: UIImage(named: "medal_icon"))
    private let leftMedalIcon = UIImageView(image: UIImage(named: "medal_icon"))
    
    private let playButton = UIButton()
    private let backButton = UIButton()
    
    var onPlayAgain: (() -> Void)?
    var onBackToMenu: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        applyAlertStyle()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        timeStackView.axis = .horizontal
        timeStackView.distribution = .equalSpacing
        timeStackView.alignment = .center
        timeStackView.spacing = 5
        
        [clockIcon, timeLabel].forEach {
            timeStackView.addArrangedSubview($0)
        }
        
        [themeLabel, cardCountLabel, textTimeLabel].forEach {
            $0.textColor = .customBlack
            $0.font = .bodyText
        }
        
        [leftMedalIcon, rightMedalIcon].forEach {
            $0.contentMode = .scaleAspectFit
        }
        
        [playButton, backButton].forEach {
            $0.backgroundColor = .customBiege
            $0.titleLabel?.font = .buttonFont
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        playButton.setTitle(Localization.playAgain, for: .normal)
        backButton.setTitle(Localization.backToMenu, for: .normal)
        
        playButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backToMenuTapped), for: .touchUpInside)
        
        textTimeLabel.text = Localization.yourTime
        
        titleLabel.textColor = .customBlue
        titleLabel.font = .secondHeader
        clockIcon.tintColor = .customBlack
        timeLabel.textColor = .customBlack
        
        [titleLabel, themeLabel, cardCountLabel, cardIcon, textTimeLabel, timeStackView, rightMedalIcon, leftMedalIcon, playButton, backButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        [titleLabel, themeLabel, cardCountLabel, textTimeLabel, timeLabel, timeStackView, cardIcon, clockIcon, rightMedalIcon, leftMedalIcon, playButton, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            leftMedalIcon.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            leftMedalIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            leftMedalIcon.widthAnchor.constraint(equalToConstant: 40),
            leftMedalIcon.heightAnchor.constraint(equalToConstant: 40),
            
            rightMedalIcon.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            rightMedalIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            rightMedalIcon.widthAnchor.constraint(equalToConstant: 40),
            rightMedalIcon.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            
            themeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            themeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            cardCountLabel.centerYAnchor.constraint(equalTo: themeLabel.centerYAnchor),
            cardCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            cardIcon.centerYAnchor.constraint(equalTo: cardCountLabel.centerYAnchor),
            cardIcon.trailingAnchor.constraint(equalTo: cardCountLabel.leadingAnchor, constant: -8),
            cardIcon.heightAnchor.constraint(equalToConstant: 24),
            cardIcon.widthAnchor.constraint(equalToConstant: 24),
            
            textTimeLabel.topAnchor.constraint(equalTo: cardIcon.bottomAnchor, constant: 20),
            textTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            timeStackView.centerXAnchor.constraint(equalTo: textTimeLabel.centerXAnchor),
            timeStackView.topAnchor.constraint(equalTo: textTimeLabel.bottomAnchor, constant: 20),
            
            clockIcon.widthAnchor.constraint(equalToConstant: 24),
            clockIcon.heightAnchor.constraint(equalToConstant: 24),
           
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
    
    func configure(title: String, theme: String, cardCount: Int, time: TimeInterval) {
        titleLabel.text = title
        themeLabel.text = theme
        cardCountLabel.text = "\(cardCount) \(Localization.cards)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        
        let formattedTime = formatter.string(from: Date(timeIntervalSinceReferenceDate: time))
        timeLabel.text = formattedTime
    }
    
    @objc private func playAgainTapped() {
        onPlayAgain?()
    }
    
    @objc private func backToMenuTapped() {
        onBackToMenu?()
    }
}
