//
//  CardCollectionViewCell.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import UIKit

final class CardCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let frontImage = UIImageView()
    private let backImage = UIImageView()
    
    private let dinosaurType: DinosaurType
    
    private let animationDuration = 0.5
    private let scaleDuration = 0.3
    private let scaleDelay = 0.1
    private let holdDuration = 0.8
    
    private let animationOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    override init(frame: CGRect) {
        self.dinosaurType = DinosaurType.allCases.randomElement() ?? .alamosaurus
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        frontImage.isHidden = true
        backImage.isHidden = false
    }
    
    private func configure() {
        setupShadowAndRadius()
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
        let dinosaurType = DinosaurType.allCases.randomElement()
        frontImage.image = UIImage(named: card.imageName)
        backImage.image = UIImage(named: dinosaurType?.backImage ?? "")
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
            if isFlipped && finished {
                self.animateScaleUpAndDown()
            }
        })
    }
    
    private func animateScaleUpAndDown() {
        UIView.animate(withDuration: scaleDuration, delay: scaleDelay, options: [], animations: {
            self.frontImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            UIView.animate(withDuration: self.scaleDuration, delay: self.holdDuration, options: [], animations: {
                self.frontImage.transform = .identity
            }, completion: nil)
        })
    }
}
