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
    private let defaultTimeText = "00:00"
    private let numberOfSections = 2
    private let recordsRows = 5
    
    private let gameRecordsCellId = String(describing: GameRecordTableViewCell.self)
    private let latestsGamesCellId = String(describing: LatestGamesTableViewCell.self)
    private let sectionHeaderId = String(describing: TableSectionHeader.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idRegister()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
    }
    
    private func loadGameData() {
        gameRecords = GameStorage.shared.loadGameRecords()
        latestGames = GameStorage.shared.loadLatestGames().reversed()
        tableView.reloadData()
    }
    
    @objc private func handleBackAction() {
        navigationController?.popViewController(animated: true)
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
        section == .zero ? recordsRows : latestGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: gameRecordsCellId, for: indexPath) as? GameRecordTableViewCell else { return UITableViewCell() }
            let cardCounts = CardCount.allCases
            let cardCount = cardCounts[indexPath.row]
            if let record = gameRecords.first(where: { $0.cardCount == cardCount.rawValue }) {
                let count = "\(record.cardCount) \(Localization.cards)"
                let time = record.completionTime.formattedTime()
                cell.configure(count: count, time: time)
            } else {
                let count = "\(cardCount.rawValue) \(Localization.cards)"
                let time = defaultTimeText
                cell.configure(count: count, time: time)
            }
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: latestsGamesCellId, for: indexPath) as? LatestGamesTableViewCell else { return UITableViewCell() }
            let game = latestGames[indexPath.row]
            let isRecord = gameRecords.contains { record in
                record.cardCount == game.cardCount && record.completionTime > game.completionTime
            }
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
