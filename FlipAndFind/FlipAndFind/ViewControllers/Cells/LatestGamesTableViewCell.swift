//
//  LatestGamesTableViewCell.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 26.04.2024.
//

import UIKit

final class LatestGamesTableViewCell: UITableViewCell {
    
    private let themeLabel = UILabel()
    private let dateLabel = UILabel()
    private let cardCountLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let cardIcon = UIImageView(image: UIImage(named: "card_icon"))
    private let clockIcon = UIImageView(image: UIImage(named: "clock_icon"))
    private let trophyIcon = UIImageView(image: UIImage(named: "trophy_icon"))
    
    private let separatorView = UIView()
    private let separatorHeight: CGFloat = 1
    
    private let iconSize: CGFloat = 28
    private let padding: CGFloat = 16
    private let trailingSpacing: CGFloat = 78
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with game: LatestGames, isRecord: Bool) {
        themeLabel.text = game.theme.localizedName
        dateLabel.text = game.date.customFormattedDateString()
        cardCountLabel.text = "\(game.cardCount) \(Localization.cards)"
        timeLabel.text = game.completionTime.formattedTime()
        
        trophyIcon.isHidden = !isRecord
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        
        let stackView = UIStackView(arrangedSubviews: [trophyIcon, themeLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        trophyIcon.isHidden = true
        
        themeLabel.numberOfLines = 0
        themeLabel.lineBreakMode = .byWordWrapping
        
        separatorView.backgroundColor = .customBlack
        
        [cardIcon, clockIcon, cardCountLabel, timeLabel, dateLabel, separatorView, stackView ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor, constant: -padding),
            
            trophyIcon.widthAnchor.constraint(equalToConstant: iconSize),
            trophyIcon.heightAnchor.constraint(equalToConstant: iconSize),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            cardIcon.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: padding),
            cardIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cardIcon.widthAnchor.constraint(equalToConstant: iconSize),
            cardIcon.heightAnchor.constraint(equalToConstant: iconSize),
            
            cardCountLabel.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            cardCountLabel.leadingAnchor.constraint(equalTo: cardIcon.trailingAnchor, constant: padding),
            
            clockIcon.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            clockIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -trailingSpacing),
            clockIcon.widthAnchor.constraint(equalToConstant: iconSize),
            clockIcon.heightAnchor.constraint(equalToConstant: iconSize),
            
            timeLabel.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: clockIcon.trailingAnchor, constant: padding),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            separatorView.heightAnchor.constraint(equalToConstant: separatorHeight),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
