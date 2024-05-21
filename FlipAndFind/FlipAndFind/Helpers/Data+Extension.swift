//
//  Data+Extension.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 21.05.2024.
//

import Foundation

extension Date {
    func formattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
