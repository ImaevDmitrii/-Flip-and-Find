//
//  UserDefaults+Extencion.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 25.04.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let cardCount = "cardCount"
        static let theme = "theme"
        static let language = "language"
    }
    
    var cardCount: Int {
        get { integer(forKey: Keys.cardCount) == 0 ? 12 : integer(forKey: Keys.cardCount) }
        set { set(newValue, forKey: Keys.cardCount) }
    }
    
    var theme: String {
        get { string(forKey: Keys.theme) ?? Theme.dinosaurio.rawValue }
        set { set(newValue, forKey: Keys.theme) }
    }
    
    var language: String {
        get { string(forKey: Keys.language) ?? Language.english.rawValue }
        set { set(newValue, forKey: Keys.language) }
    }
}
