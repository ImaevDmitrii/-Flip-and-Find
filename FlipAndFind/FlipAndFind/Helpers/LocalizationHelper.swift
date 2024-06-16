//
//  LocalizationHelper.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 16.06.2024.
//

import Foundation

final class LocalizationHelper {
    static func localizedCardCount(_ count: Int, languageCode: String) -> String {
        if languageCode == "ru" {
            let remainder100 = count % 100
            if remainder100 >= 11 && remainder100 <= 19 {
                return "карт"
            }
            switch count % 10 {
            case 1:
                return "карта"
            case 2, 3, 4:
                return "карты"
            default:
                return "карт"
            }
        } else {
            return Localization.cards
        }
    }
}
