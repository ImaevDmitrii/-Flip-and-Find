//
//  GameRecordTableViewCell.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 26.04.2024.
//

import UIKit

final class GameRecordTableViewCell: UITableViewCell {
    
    let cardCountLabel = UILabel()
    let timeLabel = UILabel()
    let cardIcon = UIImageView(image: UIImage(named: "card_icon"))
    let clockIcon = UIImageView(image: UIImage(named: "clock_icon"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        
        [cardIcon, clockIcon, cardCountLabel, timeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cardIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
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
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

