//
//  UserDefaults+Extension.swift
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
        get { string(forKey: Keys.theme) ?? Theme.birds.rawValue }
        set { set(newValue, forKey: Keys.theme) }
    }
    
    var language: String {
        get {
            let lang = string(forKey: Keys.language) ?? Language.english.rawValue
            return lang
        }
        set {
            set(newValue, forKey: Keys.language)
            NotificationCenter.default.post(name: .languageChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let languageChanged = Notification.Name("LanguageChangedNotification")
}
