//
//  SettingsModels.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 17.04.2024.
//

import Foundation

enum CardCount: Int, CaseIterable {
    case eight = 8, twelve = 12, eighteen = 18, twentyFour = 24, thirtyTwo = 32, fourty = 40
    
    var localizedName: String {
        switch self {
        case .eight: return rawValue.description
        case .twelve: return rawValue.description
        case .eighteen: return rawValue.description
        case.twentyFour: return rawValue.description
        case .thirtyTwo: return rawValue.description
        case .fourty: return rawValue.description
        }
    }
    
    var imageName: String {
        return "\(self.rawValue)"
    }
    
    func gridConfiguration(isLandscape: Bool) -> (columns: Int, rows: Int) {
        switch self {
        case .eight:
            return isLandscape ? (4, 2) : (2, 4)
        case .twelve:
            return isLandscape ? (6, 2) : (3, 4)
        case .eighteen:
            return isLandscape ? (6, 3) : (3, 6)
        case .twentyFour:
            return isLandscape ? (8, 3) : (4, 6)
        case .thirtyTwo:
            return isLandscape ? (8, 4) : (4, 8)
        case .fourty:
            return isLandscape ? (10, 4) : (5, 8)
        }
    }
}

enum Theme: String, CaseIterable, Codable {
    case birds, dinosaur, farm, garden, halloween, insect, jungle, sea, transport
    
    var localizedName: String {
        switch self {
        case .birds: return Localization.birds
        case .dinosaur: return Localization.dinosaur
        case .farm: return Localization.farm
        case .garden: return Localization.garden
        case .halloween: return Localization.halloween
        case .insect: return Localization.insects
        case .jungle: return Localization.jungle
        case .sea: return Localization.seaAnimals
        case .transport: return Localization.transport
        }
    }
    
    var imageName: String {
        return self.rawValue
    }
    
    func getFactory() -> CardTypeFactory {
        switch self {
        case .birds:
            return CardFactory(types: Birds.allCases)
        case .dinosaur:
            return CardFactory(types: Dinosaur.allCases)
        case .farm:
            return CardFactory(types: Farm.allCases)
        case .garden:
            return CardFactory(types: Garden.allCases)
        case .halloween:
            return CardFactory(types: Halloween.allCases)
        case .insect:
            return CardFactory(types: Insect.allCases)
        case .jungle:
            return CardFactory(types: Jungle.allCases)
        case .sea:
            return CardFactory(types: Sea.allCases)
        case .transport:
            return CardFactory(types: Transport.allCases)
        }
    }
}

enum Language: String, CaseIterable {
    case english = "en", russian = "ru", spanish = "es"
    
    var localizedName: String {
        switch self {
        case .english: return Localization.english
        case .russian: return Localization.russian
        case .spanish: return Localization.spanish
        }
    }
    
    var imageName: String {
        return self.rawValue
    }
    
    var string: String {
        return self.rawValue
    }
}

extension Theme {
    static func from(string: String?) -> Theme {
        guard let string = string, let theme = Theme(rawValue: string) else { return .birds }
        return theme
    }
}
