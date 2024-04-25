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
    case dinosaurio, seaanimals, halloween, farm, insects, jungle
    
    var imageName: String {
        return self.rawValue
    }
    
    func getFactory() -> CardTypeFactory {
        switch self {
        case .dinosaurio:
            CardFactory(types: DinosaurType.allCases)
        case .seaanimals:
            CardFactory(types: SeaAnimals.allCases)
        case .halloween:
            CardFactory(types: Halloween.allCases)
        case .farm:
            CardFactory(types: Farm.allCases)
        case .insects:
            CardFactory(types: Insects.allCases)
        case .jungle:
            CardFactory(types: Jungle.allCases)
        }
    }
}

enum Language: String, CaseIterable {
    case english = "eng", russian = "rus", spanish = "esp"
    
    var imageName: String {
        return self.rawValue
    }
}

