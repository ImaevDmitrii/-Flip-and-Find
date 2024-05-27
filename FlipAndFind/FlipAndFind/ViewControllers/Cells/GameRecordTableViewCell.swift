//
//  GameRecordTableViewCell.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 26.04.2024.
//

import UIKit

final class GameRecordTableViewCell: UITableViewCell {
    
    private let cardCountLabel = UILabel()
    private let timeLabel = UILabel()
    private let cardIcon = UIImageView(image: UIImage(named: "card_icon"))
    private let clockIcon = UIImageView(image: UIImage(named: "clock_icon"))
    
    
    private let iconSize: CGFloat = 24
    private let pagging: CGFloat = 10
    private let labelSpacing: CGFloat = 8
    private let trailingSPacing: CGFloat = 68
    private let leadingSpacing: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(count: String, time: String) {
        cardCountLabel.text = count
        timeLabel.text = time
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        
        [cardIcon, clockIcon, cardCountLabel, timeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cardIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: pagging),
            cardIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingSpacing),
            cardIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -pagging),
            cardIcon.widthAnchor.constraint(equalToConstant: iconSize),
            cardIcon.heightAnchor.constraint(equalToConstant: iconSize),
            
            cardCountLabel.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            cardCountLabel.leadingAnchor.constraint(equalTo: cardIcon.trailingAnchor, constant: labelSpacing),
            
            clockIcon.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            clockIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -trailingSPacing),
            clockIcon.widthAnchor.constraint(equalToConstant: iconSize),
            clockIcon.heightAnchor.constraint(equalToConstant: iconSize),
            
            timeLabel.centerYAnchor.constraint(equalTo: cardIcon.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: clockIcon.trailingAnchor, constant: labelSpacing)
        ])
    }
}

