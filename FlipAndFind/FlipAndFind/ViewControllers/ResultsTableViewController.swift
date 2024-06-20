//
//  ResultsTableViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 26.04.2024.
//

import UIKit

final class ResultsTableViewController: UITableViewController {
    
    private var gameRecords: [GameRecord] = []
    private var latestGames: [LatestGames] = []
    
    private let recordsGameKey = "gameRecords"
    private let latestGameKey = "latestGames"
    private let defaultTimeText = "-"
    private let numberOfSections = 2
    
    private let gameRecordsCellId = String(describing: GameRecordTableViewCell.self)
    private let latestsGamesCellId = String(describing: LatestGamesTableViewCell.self)
    private let sectionHeaderId = String(describing: TableSectionHeader.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idRegister()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGameData()
    }
    
    private func idRegister() {
        tableView.register(GameRecordTableViewCell.self, forCellReuseIdentifier: gameRecordsCellId)
        tableView.register(LatestGamesTableViewCell.self, forCellReuseIdentifier: latestsGamesCellId)
        tableView.register(TableSectionHeader.self, forHeaderFooterViewReuseIdentifier: sectionHeaderId)
    }
    
    private func setup() {
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        title = Localization.myGames
        navigationController?.setupNavigationBar()
        navigationController?.setupBackButton(action: #selector(handleBackAction), target: self)
        navigationController?.setupResetButton(action: #selector(handleResetAction), target: self)
    }
    
    private func loadGameData() {
        gameRecords = GameStorage.shared.loadGameRecords()
        latestGames = GameStorage.shared.loadLatestGames().reversed()
        tableView.reloadData()
    }
    
    @objc private func handleBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleResetAction() {
        showResetAlert()
    }
    
    private func showResetAlert() {
        let blurEffect = UIBlurEffect(style: .light)
        let overlayView = UIVisualEffectView(effect: blurEffect)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)
        
        let alertView = ConfirmationAlert(frame: .zero)
        alertView.configure(title: Localization.resetHistory,
                            hiddenSecondTitle: true,
                            confirmButtonTitle: Localization.yes,
                            cancelButtonTitle: Localization.no)
        view.addSubview(alertView)
        
        let padding: CGFloat = 35
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            alertView.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: padding),
            alertView.trailingAnchor.constraint(greaterThanOrEqualTo: overlayView.trailingAnchor, constant: -padding),
            alertView.heightAnchor.constraint(greaterThanOrEqualTo: overlayView.heightAnchor, multiplier: 0.4)
        ])
        
        alertView.onTopButton = { [weak self, weak overlayView, weak alertView] in
            self?.resetGameData()
            overlayView?.removeFromSuperview()
            alertView?.removeFromSuperview()
        }
        
        alertView.onBottomButton = { [weak overlayView, weak alertView] in
            overlayView?.removeFromSuperview()
            alertView?.removeFromSuperview()
        }
    }
    
    private func resetGameData() {
        UserDefaults.standard.removeObject(forKey: recordsGameKey)
        UserDefaults.standard.removeObject(forKey: latestGameKey)
        gameRecords.removeAll()
        latestGames.removeAll()
        tableView.reloadData()
    }
    
    private func saveGameData() {
        if let recordsData = try? JSONEncoder().encode(gameRecords) {
            UserDefaults.standard.set(recordsData, forKey: recordsGameKey)
        }
        
        if let latestData = try? JSONEncoder().encode(latestGames) {
            UserDefaults.standard.set(latestData, forKey: latestGameKey)
        }
    }
}

// MARK: - Table view data source

extension ResultsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == .zero ? CardCount.allCases.count : latestGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: gameRecordsCellId, for: indexPath) as? GameRecordTableViewCell else { return UITableViewCell() }
            let cardCounts = CardCount.allCases
            let cardCount = cardCounts[indexPath.row]
            
            if let record = gameRecords.first(where: { $0.cardCount == cardCount.rawValue }) {
                let count = "\(record.cardCount) \(LocalizationHelper.localizedCardCount(record.cardCount))"
                let time = record.completionTime.formattedTime()
                cell.configure(count: count, time: time)
            } else {
                let count = "\(cardCount.rawValue) \(LocalizationHelper.localizedCardCount(cardCount.rawValue))"
                let time = defaultTimeText
                cell.configure(count: count, time: time)
            }
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: latestsGamesCellId, for: indexPath) as? LatestGamesTableViewCell else { return UITableViewCell() }
            let game = latestGames[indexPath.row]
            let isRecord = GameStorage.shared.isRecord(time: game.completionTime, forCardCount: game.cardCount)
            cell.configure(with: game, isRecord: isRecord)
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderId) as? TableSectionHeader else { return nil }
        
        header.configure(title: section == .zero ? Localization.myRecords : Localization.latestGames)
        
        var backgroundConfig = UIBackgroundConfiguration.clear()
        backgroundConfig.backgroundColor = UIColor.backgroundColor
        header.backgroundConfiguration = backgroundConfig
        
        return header
    }
}
