//
//  GameStorage.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 27.04.2024.
//

import Foundation

final class GameStorage {
    static let shared = GameStorage()
    private let recordsKey = "gameRecords"
    private let latestGamesKey = "latestGames"
    
    func saveLatestGame(_ game: LatestGames) {
        var games = loadLatestGames()
        games.append(game)
        
        if games.count > 15 {
            if let gameToRemove = games.first(where: { !isBestGame($0) }) {
                if let index = games.firstIndex(of: gameToRemove) {
                    games.remove(at: index)
                }
            }
        }
        
        guard let encodedGames = try? JSONEncoder().encode(games) else { return }
        UserDefaults.standard.set(encodedGames, forKey: latestGamesKey)
        updateGameRecords(with: game)
    }
    
    private func updateGameRecords(with game: LatestGames) {
        var records = loadGameRecords()
        
        if let index = records.firstIndex(where: { $0.cardCount == game.cardCount && $0.completionTime > game.completionTime }) {
            records[index] = GameRecord(cardCount: game.cardCount, completionTime: game.completionTime)
        } else {
            records.append(GameRecord(cardCount: game.cardCount, completionTime: game.completionTime))
        }
        guard let encodedRecords = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(encodedRecords, forKey: recordsKey)
    }
    
    private func isBestGame(_ game: LatestGames) -> Bool {
           let records = loadGameRecords()
           return records.contains { $0.cardCount == game.cardCount && $0.completionTime >= game.completionTime }
       }
    
    func loadGameRecords() -> [GameRecord] {
        (try? JSONDecoder().decode([GameRecord].self, from: UserDefaults.standard.data(forKey: recordsKey) ?? Data())) ?? []
    }
    
    func loadLatestGames() -> [LatestGames] {
        (try? JSONDecoder().decode([LatestGames].self, from: UserDefaults.standard.data(forKey: latestGamesKey) ?? Data())) ?? []
    }
}
