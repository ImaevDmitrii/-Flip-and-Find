//
//  Date+Extension.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 08.05.2024.
//

import Foundation

extension Date {
    func customFormattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
