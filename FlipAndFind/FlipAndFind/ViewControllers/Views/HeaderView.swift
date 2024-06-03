//
//  HeaderView.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 24.05.2024.
//

import UIKit

final class HeaderView: UIView {
    
    private let timerIcon =  UIImageView(image: UIImage(systemName: "timer"))
    private let timerLabel = UILabel()
    private let cardsIcon = UIImageView(image: UIImage(named: "card_white"))
    private let cardsLabel = UILabel()
    
    private let startTime = "00:00"
    private let timerFormat = "%02d:%02d"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .customBlue
        
        timerIcon.tintColor = .customWhite
        
        [timerIcon, timerLabel, cardsIcon, cardsLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timerLabel.text = startTime
        
        NSLayoutConstraint.activate([
            timerIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timerIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerIcon.widthAnchor.constraint(equalToConstant: 24),
            timerIcon.heightAnchor.constraint(equalToConstant: 24),
            
            timerLabel.leadingAnchor.constraint(equalTo: timerIcon.trailingAnchor, constant: 8),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            cardsIcon.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 20),
            cardsIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardsIcon.widthAnchor.constraint(equalToConstant: 24),
            cardsIcon.heightAnchor.constraint(equalToConstant: 24),
            
            cardsLabel.leadingAnchor.constraint(equalTo: cardsIcon.trailingAnchor, constant: 8),
            cardsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        [timerLabel, cardsLabel].forEach {
            $0.textColor = .customWhite
            $0.font = .label
        }
    }
    
    func updateTimerLabel(with elapsedTime: TimeInterval) {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        timerLabel.text = String(format: timerFormat, minutes, seconds)
    }
    
    func updateCardsLabel(found: Int, total: Int) {
        cardsLabel.text = "\(found) / \(total)"
    }
}
