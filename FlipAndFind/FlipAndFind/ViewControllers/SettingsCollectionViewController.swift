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
    
    private let numberOfSections = 3
    
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
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 5, right: 20)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 5
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idRegister()
        setup()
    }
    
    private func idRegister() {
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(CollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderID)
        collectionView.register(SaveButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: saveButtonID)
    }
    
    private func setup() {
        collectionView.backgroundColor = .backgroundColor
        title = Localization.settings
        navigationController?.setupNavigationBar()
        navigationController?.setupBackButton(action: #selector(handleBackAction), target: self)
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    private func showExitAlert() {
        let blurEffect = UIBlurEffect(style: .light)
        let overlayView = UIVisualEffectView(effect: blurEffect)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)
        
        let alertView = ConfirmationAlert(frame: .zero)
        alertView.configure(title: Localization.saveChanges,
                            hiddenSecondTitle: true,
                            confirmButtonTitle: Localization.yes,
                            cancelButtonTitle: Localization.no)
        view.addSubview(alertView)
        
        let padding: CGFloat = 36
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            alertView.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: padding),
            alertView.trailingAnchor.constraint(greaterThanOrEqualTo: overlayView.trailingAnchor, constant: -padding),
            alertView.heightAnchor.constraint(greaterThanOrEqualTo: overlayView.heightAnchor, multiplier: 0.3)
        ])
        
        alertView.onTopButton = { [weak self, weak overlayView, weak alertView] in
            self?.saveButtonTapped()
            overlayView?.removeFromSuperview()
            alertView?.removeFromSuperview()
        }
                
        alertView.onBottomButton = { [weak self, weak overlayView, weak alertView] in
            overlayView?.removeFromSuperview()
            alertView?.removeFromSuperview()
            self?.navigationController?.popViewController(animated: true)
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
        NotificationCenter.default.post(name: .languageChanged, object: nil)
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
        numberOfSections
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
        
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        
        switch indexPath.section {
        case 0:
            let currendCardCount = CardCount.allCases[indexPath.item]
            cell.configure(with: currendCardCount.imageName, isSelected: currendCardCount == self.cardCount, text: currendCardCount.localizedName + " " + LocalizationHelper.localizedCardCount(currendCardCount.rawValue, languageCode: languageCode))
        case 1:
            let currentTheme = Theme.allCases[indexPath.item]
            cell.configure(with: currentTheme.imageName, isSelected: currentTheme == self.theme, text: currentTheme.localizedName)
        case 2:
            let currentLanguage = Language.allCases[indexPath.item]
            cell.configure(with: currentLanguage.imageName, isSelected: currentLanguage == self.language, text: currentLanguage.localizedName)
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

//MARK: UICollectionViewDelegateFlowLayout

extension SettingsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width / 3 - 20, height: 160)
        }
    
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
                header.configure(title: Localization.numberOfCards)
            case 1:
                header.configure(title: Localization.gameTheme)
            case 2:
                header.configure(title: Localization.language)
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

