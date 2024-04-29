//
//  SettingsCollectionViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 17.04.2024.
//

import UIKit

final class SettingsCollectionViewController: UICollectionViewController {
    
    private let cellID = String(describing: SettingsCell.self)
    private let sectionHeaderID = String(describing: CollectionSectionHeader.self)
    private let saveButtonID = String(describing: SaveButton.self)
    
    private let saveButton = UIButton()
    
    private var settingsChanged = false
    
    private var cardCount: CardCount = CardCount(rawValue: UserDefaults.standard.cardCount) ?? .eighteen {
        didSet { settingsChanged = true }
    }
    private var theme: Theme = Theme(rawValue: UserDefaults.standard.theme) ?? .dinosaurio {
        didSet { settingsChanged = true }
    }
    private var language: Language = Language(rawValue: UserDefaults.standard.language) ?? .english {
        didSet { settingsChanged = true }
    }
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 32, left: 28, bottom: 20, right: 28)
        layout.minimumLineSpacing = 10
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(CollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderID)
        collectionView.register(SaveButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: saveButtonID)
        setup()
        setupNavigationBar()
    }
    
    private func setup() {
        collectionView.backgroundColor = .backgroundColor
        title = "Settings"
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBackAction))
    }
    
    private func showExitAlert() {
        let alertView = ExitAlert(frame: .zero)
        alertView.configure(title: "Save changes?",
                            hiddenSecondTitle: true,
                            confirmButtonTitle: "Yes",
                            cancelButtonTitle: "No")
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            alertView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250)
        ])
        
        alertView.onTopButton = { [weak self] in
            self?.saveButtonTapped()
        }
        alertView.onBottomButton = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleBackAction() {
        if settingsChanged {
            showExitAlert()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func saveButtonTapped() {
        UserDefaults.standard.cardCount = cardCount.rawValue
        UserDefaults.standard.theme = theme.rawValue
        UserDefaults.standard.language = language.rawValue
        settingsChanged = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.saveButton.alpha = 0.6
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.saveButton.alpha = 1.0
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: UICollectionViewDataSource

extension SettingsCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return CardCount.allCases.count
        case 1: return Theme.allCases.count
        case 2: return Language.allCases.count
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SettingsCell else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            let currendCardCount = CardCount.allCases[indexPath.item]
            cell.configure(with: currendCardCount.imageName, isSelected: currendCardCount == self.cardCount)
        case 1:
            let currentTheme = Theme.allCases[indexPath.item]
            cell.configure(with: currentTheme.imageName, isSelected: currentTheme == self.theme)
        case 2:
            let currentLanguage = Language.allCases[indexPath.item]
            cell.configure(with: currentLanguage.imageName, isSelected: currentLanguage == self.language)
        default: break
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            cardCount = CardCount.allCases[indexPath.item]
        case 1:
            theme = Theme.allCases[indexPath.item]
        case 2:
            language = Language.allCases[indexPath.item]
        default: break
        }
        collectionView.reloadData()
    }
    
}

extension SettingsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == collectionView.numberOfSections - 1 {
            return CGSize(width: collectionView.bounds.width, height: 90)
        }
        return CGSize.zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderID, for: indexPath) as? CollectionSectionHeader else {
                return UICollectionReusableView()
            }
            
            switch indexPath.section {
            case 0:
                header.configure(title: "Number of cards")
            case 1:
                header.configure(title: "Game theme")
            case 2:
                header.configure(title: "Language")
            default:
                break
            }
            
            return header
            
        } else if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: saveButtonID, for: indexPath) as? SaveButton else {
                return UICollectionReusableView()
            }
            
            if indexPath.section == collectionView.numberOfSections - 1 {
                footer.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            }
            return footer
        }
        return UICollectionReusableView()
    }
}

