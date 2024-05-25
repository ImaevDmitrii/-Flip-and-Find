//
//  GameViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 24.05.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    private let gameModel = GameModel()
    private let bigImageView = UIImageView()
    private var theme: Theme?
    private var cardViews: [CardView] = []
    
    private let horizontalSpacing: CGFloat = 10.0
    private let verticalSpacing: CGFloat = 10.0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initializeTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        title = theme?.localizedName
        setupBigImageView()
        setupGame()
    }
    
    private func initializeTheme() {
        let themeString = UserDefaults.standard.string(forKey: "theme")
        theme = Theme.from(string: themeString)
    }
    
    private func setupBigImageView() {
            view.addSubview(bigImageView)
            bigImageView.layer.cornerRadius = 10
            bigImageView.clipsToBounds = true
            bigImageView.layer.opacity = 0
            bigImageView.contentMode = .scaleAspectFit
            bigImageView.translatesAutoresizingMaskIntoConstraints = false
            bigImageView.isHidden = true // Изначально скрываем большое изображение
            NSLayoutConstraint.activate([
                bigImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                bigImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                bigImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                bigImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }

        private func showBigImage(with imageName: String) {
            bigImageView.image = UIImage(named: imageName)
            bigImageView.isHidden = false
            view.bringSubviewToFront(bigImageView) // Перемещаем большое изображение на передний план
            bigImageView.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.bigImageView.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 1.0, options: [], animations: {
                    self.bigImageView.alpha = 0
                }, completion: { _ in
                    self.bigImageView.isHidden = true
                })
            })
        }
    
    private func setupGame() {
        let selectedCardCount = UserDefaults.standard.cardCount
        let selectedTheme = Theme(rawValue: UserDefaults.standard.theme) ?? .dinosaurio
        let factory = selectedTheme.getFactory()
        gameModel.setupGame(numberOfPairs: 1, factory: factory)
        setupCardViews()
    }
    
    private func setupCardViews() {
        // Remove any existing card views
        cardViews.forEach { $0.removeFromSuperview() }
        cardViews = []

        // Calculate the grid dimensions
        let cardCount = gameModel.cards.count
        let columns = Int(sqrt(Double(cardCount)).rounded(.up))
        let rows = (cardCount + columns - 1) / columns

        // Calculate card size with spacing
        let totalHorizontalSpacing = CGFloat(columns + 1) * horizontalSpacing
        let totalVerticalSpacing = CGFloat(rows + 1) * verticalSpacing
        let cardWidth = (view.bounds.width - totalHorizontalSpacing) / CGFloat(columns)
        let cardHeight = (view.bounds.height - totalVerticalSpacing) / CGFloat(rows)
        
        for (index, card) in gameModel.cards.enumerated() {
            let cardView = CardView()
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.configureCard(with: card)
            cardView.onShowBigImage = { [weak self] imageName in
                self?.showBigImage(with: imageName)
            }
            cardView.tag = index
            cardViews.append(cardView)
            view.addSubview(cardView)

            let column = index % columns
            let row = index / columns

            NSLayoutConstraint.activate([
                cardView.widthAnchor.constraint(equalToConstant: cardWidth),
                cardView.heightAnchor.constraint(equalToConstant: cardHeight),
                cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(column) * (cardWidth + horizontalSpacing) + horizontalSpacing),
                cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(row) * (cardHeight + verticalSpacing) + verticalSpacing)
            ])

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(_:)))
            cardView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func handleCardTap(_ gesture: UITapGestureRecognizer) {
        guard let cardView = gesture.view as? CardView else { return }
        let index = cardView.tag
        if !gameModel.cards[index].isMatched {
            let cardIsFlipped = gameModel.cards[index].isFlipped
            gameModel.flipCard(index: index)
            cardView.flip(to: !cardIsFlipped)
            
            if let firstIndex = gameModel.firstFlippedCardIndex, firstIndex != index {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.gameModel.flipBack(firstIndex: firstIndex, secondIndex: index)
                    [firstIndex, index].forEach { idx in
                        if let cardView = self.cardViews.first(where: { $0.tag == idx }) {
                            cardView.flip(to: self.gameModel.cards[idx].isFlipped)
                        }
                    }
                }
            }
            if gameModel.checkAllPairsFound() {
                showGameOverAlert()
            }
        }
    }
    
    
    private func showGameOverAlert() {
        let blurEffect = UIBlurEffect(style: .light)
        let overlayView = UIVisualEffectView(effect: blurEffect)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)
        
        let alertView = GameEndAlert(frame: .zero)
        alertView.configure(title: Localization.youWon,
                            theme: theme?.localizedName ?? "",
                            cardCount: gameModel.cards.count / 2,
                            time: gameModel.calculateCompletionTime())
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            alertView.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: 16),
            alertView.trailingAnchor.constraint(greaterThanOrEqualTo: overlayView.trailingAnchor, constant: -16),
            alertView.heightAnchor.constraint(lessThanOrEqualTo: overlayView.heightAnchor, multiplier: 1.0)
        ])
        
        alertView.onPlayAgain = { [weak self, weak overlayView] in
            self?.setupGame()
            overlayView?.removeFromSuperview()
            alertView.removeFromSuperview()
        }
        
        alertView.onBackToMenu = { [weak self, weak overlayView] in
            overlayView?.removeFromSuperview()
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
