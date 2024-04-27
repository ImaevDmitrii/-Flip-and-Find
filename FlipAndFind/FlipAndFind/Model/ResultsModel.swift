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

struct LatestGames: Codable {
    let theme: Theme
    let date: Date
    let cardCount: Int
    let completionTime: TimeInterval
}

extension Date {
    func formattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

extension TimeInterval {
    func formattedTime() -> String {
        let time = Int(self)
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
