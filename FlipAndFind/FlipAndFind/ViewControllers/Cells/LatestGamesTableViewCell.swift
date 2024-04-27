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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with game: LatestGames, isRecord: Bool) {
        themeLabel.text = game.theme.rawValue
        dateLabel.text = game.date.formattedDateString()
        cardCountLabel.text = "\(game.cardCount) Cards"
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
        
        separatorView.backgroundColor = .customBlack
        
        [cardIcon, clockIcon, cardCountLabel, timeLabel, dateLabel, separatorView, stackView ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor, constant: -8),
            
            trophyIcon.widthAnchor.constraint(equalToConstant: 24),
            trophyIcon.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            cardIcon.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 8),
            cardIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardIcon.widthAnchor.constraint(equalToConstant: 24),
            cardIcon.heightAnchor.constraint(equalToConstant: 24),
            
            cardCountLabel.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            cardCountLabel.leadingAnchor.constraint(equalTo: cardIcon.trailingAnchor, constant: 8),
            
            clockIcon.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            clockIcon.leadingAnchor.constraint(equalTo: cardCountLabel.trailingAnchor, constant: 16),
            clockIcon.widthAnchor.constraint(equalToConstant: 24),
            clockIcon.heightAnchor.constraint(equalToConstant: 24),
            
            timeLabel.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: clockIcon.trailingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
