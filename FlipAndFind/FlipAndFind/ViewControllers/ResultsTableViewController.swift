//
//  ResultsTableViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 26.04.2024.
//

import UIKit

final class ResultsTableViewController: UITableViewController {
    
    var gameRecords: [GameRecord] = []
    var latestGames: [LatestGames] = []
    
    private let gameRecordsCellId = String(describing: GameRecordTableViewCell.self)
    private let latestsGamesCellId = String(describing: LatestGamesTableViewCell.self)
    private let sectionHeaderId = String(describing: TableSectionHeader.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GameRecordTableViewCell.self, forCellReuseIdentifier: gameRecordsCellId)
        tableView.register(LatestGamesTableViewCell.self, forCellReuseIdentifier: latestsGamesCellId)
        tableView.register(TableSectionHeader.self, forHeaderFooterViewReuseIdentifier: sectionHeaderId)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadGameData()
    }
    
    private func setup() {
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        title = "My Games"
    }
    
    private func loadGameData() {
        gameRecords = GameStorage.shared.loadGameRecords()
        latestGames = GameStorage.shared.loadLatestGames()
        tableView.reloadData()
    }
    
    private func saveGameData() {
        if let recordsData = try? JSONEncoder().encode(gameRecords) {
            UserDefaults.standard.set(recordsData, forKey: "gameRecords")
        }
        
        if let latestData = try? JSONEncoder().encode(latestGames) {
            UserDefaults.standard.set(latestData, forKey: "latestGames")
        }
    }
}

// MARK: - Table view data source

extension ResultsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 5 : latestGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: gameRecordsCellId, for: indexPath) as! GameRecordTableViewCell
            let cardCounts = [8, 12, 18, 24, 32]
            let cardCount = cardCounts[indexPath.row]
            if let record = gameRecords.first(where: { $0.cardCount == cardCount }) {
                cell.cardCountLabel.text = "\(record.cardCount) Cards"
                cell.timeLabel.text = record.completionTime.formattedTime()
            } else {
                cell.cardCountLabel.text = "\(cardCount) Cards"
                cell.timeLabel.text = "-"
            }
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: latestsGamesCellId, for: indexPath) as! LatestGamesTableViewCell
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
        
        header.configure(title: section == 0 ? "My records" : "Latest games")
        
        return header
    }
}
