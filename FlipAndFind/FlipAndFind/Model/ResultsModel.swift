//
//  ResultsModel.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 26.04.2024.
//

import Foundation

struct GameRecord: Codable {
    let cardCount: Int
    let completionTime: TimeInterval
}

struct LatestGames: Codable, Equatable {
    let theme: Theme
    let date: Date
    let cardCount: Int
    let completionTime: TimeInterval
}

extension LatestGames {
    static func == (lhs: LatestGames, rhs: LatestGames) -> Bool {
        return lhs.date == rhs.date && lhs.cardCount == rhs.cardCount && lhs.completionTime == rhs.completionTime
    }
}
