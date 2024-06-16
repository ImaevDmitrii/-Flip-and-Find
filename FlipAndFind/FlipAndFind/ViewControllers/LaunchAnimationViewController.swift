//
//  LaunchAnimationViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 17.05.2024.
//

import UIKit

final class LaunchAnimationViewController: UIViewController {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let firstSquare = UIView()
    private let secondSquare = UIView()
    private let thirdSquare = UIView()
    private let fourthSquare = UIView()
    
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        initialAnimations()
    }
    
    private func setupViews() {
        view.backgroundColor = .backgroundColor
        
        containerView.backgroundColor = .customBlue
        containerView.layer.cornerRadius = 50
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        titleLabel.text = "Memory \nBoom"
        titleLabel.textColor = .customWhite
        titleLabel.font = .logoMain
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = Localization.slogan
        subtitleLabel.textColor = .black
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        subtitleLabel.textAlignment = .center
        
        [firstSquare, secondSquare, thirdSquare, fourthSquare].forEach {
            $0.backgroundColor = .customWhite
            $0.layer.cornerRadius = 20
            $0.alpha = 1
            $0.transform = CGAffineTransform(rotationAngle: -.pi * 33.29 / 180)
            containerView.addSubview($0)
        }
        
        [titleLabel, subtitleLabel].forEach {
            containerView.addSubview($0)
        }
        
        view.addSubview(containerView)
    }
    
    private func setupConstraints() {
        let squareSize = view.bounds.width * 0.30
        let padding: CGFloat = 20
        let bigPadding: CGFloat = 40
        let spacing: CGFloat = 60
        
        [containerView, titleLabel, subtitleLabel, firstSquare, secondSquare, thirdSquare, fourthSquare].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -padding),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            
            firstSquare.widthAnchor.constraint(equalToConstant: squareSize),
                firstSquare.heightAnchor.constraint(equalToConstant: squareSize),
                firstSquare.topAnchor.constraint(equalTo: containerView.topAnchor, constant: spacing),
                firstSquare.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                
                secondSquare.widthAnchor.constraint(equalToConstant: squareSize),
                secondSquare.heightAnchor.constraint(equalToConstant: squareSize),
                secondSquare.topAnchor.constraint(equalTo: containerView.topAnchor, constant: spacing),
                secondSquare.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                
                thirdSquare.widthAnchor.constraint(equalToConstant: squareSize),
                thirdSquare.heightAnchor.constraint(equalToConstant: squareSize),
                thirdSquare.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -spacing),
                thirdSquare.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: bigPadding),
                
                fourthSquare.widthAnchor.constraint(equalToConstant: squareSize),
                fourthSquare.heightAnchor.constraint(equalToConstant: squareSize),
                fourthSquare.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -spacing),
                fourthSquare.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -bigPadding)

        ])
    }
    
    private func initialAnimations() {
        UIView.animate(withDuration: 1.3, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.firstSquare.transform = self.firstSquare.transform.translatedBy(x: 0, y: -self.view.bounds.width)
            self.secondSquare.transform = self.secondSquare.transform.translatedBy(x: self.view.bounds.width, y: 0)
            self.thirdSquare.transform = self.thirdSquare.transform.translatedBy(x: -self.view.bounds.width, y: 0)
            self.fourthSquare.transform = self.fourthSquare.transform.translatedBy(x: 0, y: self.view.bounds.width)
            self.subtitleLabel.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
                let totalHeight = self.view.bounds.height
                let headerHeight = self.view.bounds.height * 0.3
                let finalHeight = totalHeight - headerHeight
                
                self.containerView.transform = CGAffineTransform(translationX: 0, y: -finalHeight)
            }, completion: { _ in
                self.completionHandler?()
            })
        })
    }
}
