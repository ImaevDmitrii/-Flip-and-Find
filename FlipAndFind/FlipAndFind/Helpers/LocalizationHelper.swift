//
//  LocalizationHelper.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 16.06.2024.
//

import Foundation

final class LocalizationHelper {
    static func localizedCardCount(_ count: Int) -> String {
        switch count {
        case 24, 32:
            return Localization.manyCard
        default:
            return Localization.cards
        }
    }
}
