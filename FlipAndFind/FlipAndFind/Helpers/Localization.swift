//
//  Localization.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 14.04.2024.
//

import Foundation

extension String {
    var localizaed: String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
    
    struct Localization {
        static let newGame = "New Game".localizaed
        static let myGames = "My Games".localizaed
        static let settings = "Settings".localizaed
    }
