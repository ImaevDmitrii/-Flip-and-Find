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

enum Theme: String, CaseIterable, Codable {
    case dinosaurio, seaanimals, halloween, farm, insects, jungle
    
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
    
    var imageName: String {
        return self.rawValue
    }
    
    var string: String {
        return self.rawValue
    }
}

