//
//  GameCollectionViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import UIKit

final class GameCollectionViewController: UICollectionViewController {
    
    private let cellId = String(describing: CardCell.self)
    private let gameModel = GameModel()
    
    private let bigImageView = UIImageView()
    
    private var theme: Theme?
    
    init(){
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        configureLayout()
        initializeTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: cellId)
        setup()
        setupBigImageView()
        setupGame()
    }
    
    override func viewWillLayoutSubviews() {
        updateLayoutForSize(view.bounds.size)
    }
    
    private func initializeTheme() {
            let themeString = UserDefaults.standard.string(forKey: "theme")
            theme = Theme.from(string: themeString)
        }
    
    private func setup() {
        collectionView.backgroundColor = .backgroundColor
        title = theme?.localizedName
        navigationController?.setupNavigationBar()
        navigationController?.setupBackButton(action: #selector(handleBackAction), target: self)
    }
    
    private func setupBigImageView() {
        view.addSubview(bigImageView)
        
        bigImageView.layer.cornerRadius = 10
        bigImageView.clipsToBounds = true
        bigImageView.layer.opacity = 0
        bigImageView.contentMode = .scaleAspectFit
        
        bigImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            bigImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            bigImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureLayout() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
    }
    
    private func updateLayoutForSize(_ size: CGSize) {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let numberOfColumns: CGFloat = size.width > size.height ? 6 : 4
        let padding: CGFloat = 20
        let minimumItemSpacing: CGFloat = 15
        let availableWidth = size.width - padding * 2 - (numberOfColumns - 1) * minimumItemSpacing
        let itemWidth = availableWidth / numberOfColumns
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
    }
    
    private func setupGame() {
        let selectedCardCount = UserDefaults.standard.cardCount
        let selectedTheme = Theme(rawValue: UserDefaults.standard.theme) ?? .dinosaurio
        let factory = selectedTheme.getFactory()
        gameModel.setupGame(numberOfPairs: selectedCardCount, factory: factory)
        collectionView.reloadData()
    }
    
    private func showBigImage(with imageName: String) {
        bigImageView.image = UIImage(named: imageName)
        bigImageView.isHidden = false
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
    
    private func showExitAlert() {
        let blurEffect = UIBlurEffect(style: .light)
        let overlayView = UIVisualEffectView(effect: blurEffect)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)
        
        let alertView = ExitAlert(frame: CGRect.zero)
        alertView.configure(title: Localization.doYouWantToLeave,
                            hiddenSecondTitle: false,
                            confirmButtonTitle: Localization.keepPlaying,
                            cancelButtonTitle: Localization.leaveGame)
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            alertView.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: 16),
            alertView.trailingAnchor.constraint(greaterThanOrEqualTo: overlayView.trailingAnchor, constant: -16),
            alertView.heightAnchor.constraint(lessThanOrEqualTo: overlayView.heightAnchor, multiplier: 0.8)
                
        ])
        
        alertView.onTopButton = { [weak self, weak overlayView] in
            self?.gameModel.resumeTimer()
            overlayView?.removeFromSuperview()
            alertView.removeFromSuperview()
        }
        alertView.onBottomButton = { [weak self, weak overlayView] in
            overlayView?.removeFromSuperview()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleBackAction() {
        if !gameModel.checkAllPairsFound() {
            gameModel.pauseTimer()
            showExitAlert()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: UICollectionViewDataSource

extension GameCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameModel.cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CardCell else { return UICollectionViewCell() }
        
        let card = gameModel.cards[indexPath.row]
        cell.configureCard(with: card)
        cell.onShowBigImage = { [weak self] imageName in
            self?.showBigImage(with: imageName)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell,
              !gameModel.cards[indexPath.row].isMatched else { return }
        
        let cardIsFlipped = gameModel.cards[indexPath.row].isFlipped
        gameModel.flipCard(index: indexPath.row)
        
        collectionView.reloadItems(at: [indexPath])
        
        cell.flip(to: !cardIsFlipped)
        
        if let firstIndex = gameModel.firstFlippedCardIndex, firstIndex != indexPath.row {
            collectionView.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.gameModel.flipBack(firstIndex: indexPath.row, secondIndex: indexPath.row)
                let indexesToReload = [IndexPath(row: firstIndex, section: 0), indexPath]
                collectionView.reloadItems(at: indexesToReload)
                
                indexesToReload.forEach { indexPath in
                    if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
                        cell.flip(to: self.gameModel.cards[indexPath.row].isFlipped)
                    }
                }
                collectionView.isUserInteractionEnabled = true
            }
        }
        if gameModel.checkAllPairsFound() {
            showGameOverAlert()
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
            alertView.heightAnchor.constraint(lessThanOrEqualTo: overlayView.heightAnchor, multiplier: 0.8)
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
