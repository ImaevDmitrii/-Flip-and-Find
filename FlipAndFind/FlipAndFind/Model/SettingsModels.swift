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
    case dinosaurio, seaanimals, halloween, farm, insects, jungle
    
    var localizedName: String {
        switch self {
        case .dinosaurio: return Localization.dinosaur
        case .seaanimals: return Localization.seaAnimals
        case .halloween: return Localization.halloween
        case .farm: return Localization.farm
        case .insects: return Localization.insects
        case .jungle: return Localization.jungle
        }
    }
    
    var imageName: String {
        return self.rawValue
    }
    
    func getFactory() -> CardTypeFactory {
        switch self {
        case .dinosaurio:
            CardFactory(types: DinosaurType.allCases)
        case .seaanimals:
            CardFactory(types: SeaAnimalsType.allCases)
        case .halloween:
            CardFactory(types: HalloweenType.allCases)
        case .farm:
            CardFactory(types: FarmType.allCases)
        case .insects:
            CardFactory(types: InsectsType.allCases)
        case .jungle:
            CardFactory(types: JungleType.allCases)
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
        guard let string = string, let theme = Theme(rawValue: string) else { return .dinosaurio }
        return theme
    }
}
