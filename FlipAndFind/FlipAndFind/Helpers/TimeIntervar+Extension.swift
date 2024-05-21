//
//  TimeIntervar+Extension.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 21.05.2024.
//

import Foundation

extension TimeInterval {
    func formattedTime() -> String {
        let time = Int(self)
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
