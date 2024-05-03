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
    
    init(){
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: cellId)
        setup()
        setupBigImageView()
        setupNavigationBar()
        setupGame()
    }
    
    override func viewWillLayoutSubviews() {
        updateLayoutForSize(view.bounds.size)
    }
    
    private func setup() {
        collectionView.backgroundColor = .backgroundColor
        title = UserDefaults.standard.theme
    }
    
    private func setupBigImageView() {
        view.addSubview(bigImageView)
        
        bigImageView.layer.cornerRadius = 10
        bigImageView.clipsToBounds = true
        bigImageView.layer.opacity = 0
        bigImageView.contentMode = .scaleAspectFit
        
        bigImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigImageView.widthAnchor.constraint(equalToConstant: 200),
            bigImageView.heightAnchor.constraint(equalToConstant: 200),
            bigImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBackAction))
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
        let alertView = ExitAlert(frame: .zero)
        alertView.configure(title: "Do you want to leave the game?",
                            hiddenSecondTitle: false,
                            confirmButtonTitle: "Keep playing",
                            cancelButtonTitle: "Leave the game")
        
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
        
        alertView.onTopButton = { [weak self] in
            self?.gameModel.resumeTimer()
            alertView.removeFromSuperview()
        }
        alertView.onBottomButton = { [weak self] in
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
        let alertView = GameEndAlert(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        alertView.configure(title: "You won!", theme: gameModel.currentTheme?.rawValue ?? "Error", cardCount: gameModel.cards.count / 2, time: String(format: "%.2f", gameModel.calculateCompletionTime()))
        
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
        
        alertView.onPlayAgain = { [weak self] in
            self?.setupGame()
            alertView.removeFromSuperview()
        }
        
        alertView.onBackToMenu = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

