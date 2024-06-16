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
    static var newGame: String { "newGame".localized }
    static var myGames: String { "myGames".localized }
    static var settings: String { "settings".localized }
    static var saveChanges: String { "saveChanges".localized }
    static var yes: String { "yes".localized }
    static var no: String { "no".localized }
    static var numberOfCards: String { "numberOfCards".localized }
    static var gameTheme: String { "gameTheme".localized }
    static var language: String { "language".localized }
    static var doYouWantToLeave: String { "doYouWantToLeave".localized }
    static var keepPlaying: String { "keepPlaying".localized }
    static var leaveGame: String { "leaveGame".localized }
    static var youWon: String { "youWon".localized }
    static var cards: String { "cards".localized }
    static var myRecords: String { "myRecords".localized }
    static var latestGames: String { "latestGames".localized }
    static var save: String { "save".localized }
    static var playAgain: String { "playAgain".localized }
    static var backToMenu: String { "backToMenu".localized }
    static var yourTime: String { "yourTime".localized }
    static var youWillLoseProgress: String { "youWillLoseProgress".localized }
    static var dinosaur: String {"dinosaur".localized }
    static var seaAnimals: String { "seaAnimals".localized }
    static var halloween: String { "halloween".localized }
    static var farm: String { "farm".localized }
    static var insects: String { "insects".localized }
    static var jungle: String { "jungle".localized }
    static var slogan: String { "slogan".localized }
    static var english: String { "english".localized }
    static var russian: String { "russian".localized }
    static var spanish: String { "spanish".localized }
    static var resetHistory: String { "resetHistory".localized }
}
