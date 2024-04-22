//
//  SettingsCollectionViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 17.04.2024.
//

import UIKit

final class SettingsCollectionViewController: UICollectionViewController {
    
    private let cellID = String(describing: SettingsCell.self)
    private let sectionHeaderID = String(describing: SectionHeader.self)
    private let saveButtonID = String(describing: SaveButton.self)
    
    private var cardCount: CardCount = .eight
    private var theme: Theme = .dinosaurio
    private var language: Language = .english
    
    private let saveButton = UIButton()
    
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
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderID)
        collectionView.register(SaveButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: saveButtonID)
        setup()
    }
    
    private func setup() {
        collectionView.backgroundColor = .backgroundColor
        title = "Settings"
    }
    
    @objc private func tapSaveButton() {
        saveButton.alpha = 0.6
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
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderID, for: indexPath) as? SectionHeader else {
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
                footer.saveButton.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
            }
            return footer
        }
        return UICollectionReusableView()
    }
}

