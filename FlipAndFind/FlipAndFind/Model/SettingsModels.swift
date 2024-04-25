//
//  SettingsModels.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 17.04.2024.
//

import Foundation

enum CardCount: Int, CaseIterable {
    case eight = 8, twelve = 12, eighteen = 18, twentyFour = 24, thirty = 32
    
    var imageName: String {
        return "\(self.rawValue) card"
    }
}

enum Theme: String, CaseIterable {
    case dinosaurio
    
    var imageName: String {
        return self.rawValue
    }
    
    func getFactory() -> CardTypeFactory {
        switch self {
        case .dinosaurio:
            return CardFactory(types: DinosaurType.allCases)
        }
    }
}

enum Language: String, CaseIterable {
    case english = "eng", russian = "rus", spanish = "esp"
    
    var imageName: String {
        return self.rawValue
    }
}

