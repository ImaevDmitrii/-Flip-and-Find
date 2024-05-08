//
//  Localization.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 14.04.2024.
//

import Foundation

extension String {
    var localized: String {
        let lang = UserDefaults.standard.string(forKey: "language") ?? "en"
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

struct Localization {
    static var newGame: String { "New Game".localized }
    static var myGames: String { "My Games".localized }
    static var settings: String { "Settings".localized }
    static var saveChanges: String { "Save changes?".localized }
    static var yes: String { "Yes".localized }
    static var no: String { "No".localized }
    static var numberOfCards: String { "Number of cards".localized }
    static var gameTheme: String { "Game theme".localized }
    static var language: String { "Language".localized }
    static var doYouWantToLeave: String { "Do you want to leave the game?".localized }
    static var keepPlaying: String { "Keep playing".localized }
    static var leaveGame: String { "Leave the game".localized }
    static var youWon: String { "You won!".localized }
    static var cards: String { "cards".localized }
    static var myRecords: String { "My records".localized }
    static var latestGames: String { "Latest games".localized }
    static var save: String { "Save".localized }
    static var playAgain: String { "Play again".localized }
    static var backToMenu: String { "Back to menu".localized }
    static var yourTime: String { "Your Time".localized }
    static var youWillLoseProgress: String { "Your will lose all your progress".localized }
}
