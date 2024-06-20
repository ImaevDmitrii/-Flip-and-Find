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
    private let cardStackView = UIStackView()
    
    private let cardIcon = UIImageView(image: UIImage(named: "card_icon"))
    private let clockIcon = UIImageView(image: UIImage(systemName: "timer"))
    
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
        [timeStackView, cardStackView].forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.alignment = .center
            $0.spacing = 5
        }
        
        [clockIcon, timeLabel].forEach {
            timeStackView.addArrangedSubview($0)
        }
        
        [cardIcon, cardCountLabel].forEach {
            cardStackView.addArrangedSubview($0)
        }
        
        [clockIcon, cardIcon].forEach {
            $0.tintColor = .customBlack
        }
        
        [themeLabel, cardCountLabel, textTimeLabel, timeLabel].forEach {
            $0.textColor = .customBlack
            $0.font = .bodyText
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
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        timeLabel.textColor = .customBlack
        
        [titleLabel, themeLabel, cardStackView, textTimeLabel, timeStackView, playButton, backButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let iconSize: CGFloat = 24
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 10
        let padding: CGFloat = 20
        let spacing: CGFloat = 30
        let titlePadding: CGFloat = 35
        
        [titleLabel, themeLabel, textTimeLabel, cardStackView, timeStackView, playButton, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [clockIcon, cardIcon].forEach {
            $0.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            $0.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titlePadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -titlePadding),
            
            themeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            themeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            cardStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            cardStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            textTimeLabel.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: padding),
            textTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            timeStackView.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: padding),
            timeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
           
            playButton.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: padding),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            playButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            backButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: buttonSpacing),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            backButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
    }
    
    func configure(title: String, theme: String, cardCount: Int, time: TimeInterval) {
        titleLabel.text = title
        themeLabel.text = theme
        cardCountLabel.text = "\(cardCount) \(LocalizationHelper.localizedCardCount(cardCount))"
        
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
