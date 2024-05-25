//
//  CardView.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 24.05.2024.
//

import UIKit

final class CardView: UIView {
    
    private let containerView = UIView()
    private let frontImage = UIImageView()
    private let backImage = UIImageView()
    
    private var cardModel: CardModel?
    
    private let animationDuration = 0.5
    private let animationOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    var onShowBigImage: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupShadowAndRadius()
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        [frontImage, backImage].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: containerView.topAnchor),
                $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            $0.contentMode = .scaleAspectFit
        }
        frontImage.isHidden = true
    }
    
    private func setupShadowAndRadius() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.4
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    func configureCard(with card: CardModel) {
        cardModel = card
        frontImage.image = UIImage(named: card.imageName)
        backImage.image = UIImage(named: card.cardType.backImage)
        updateVisibility(isFlipped: card.isFlipped)
    }
    
    private func updateVisibility(isFlipped: Bool) {
        frontImage.isHidden = !isFlipped
        backImage.isHidden = isFlipped
    }
    
    func flip(to isFlipped: Bool) {
            UIView.transition(with: containerView, duration: animationDuration, options: animationOptions, animations: {
                self.updateVisibility(isFlipped: isFlipped)
            }, completion: { finished in
                if finished {
                    self.cardModel?.isFlipped = isFlipped
                    if let imageName = self.cardModel?.imageName, isFlipped {
                        self.onShowBigImage?(imageName)
                    }
                }
            })
        }
}
