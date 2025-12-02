//
//  String+.swift
//  LearnDot
//
//  Created by 신혜연 on 12/1/25.
//

import Foundation

extension String {
    func toBrailleDotSpeech() -> String {
        return self.map { char -> String in
            guard let scalar = char.unicodeScalars.first,
                  scalar.value >= 0x2800 && scalar.value <= 0x28FF else {
                return ""
            }
            
            let val = scalar.value - 0x2800
            var dots: [String] = []
            
            if (val & 0b00000001) != 0 { dots.append("1") }
            if (val & 0b00000010) != 0 { dots.append("2") }
            if (val & 0b00000100) != 0 { dots.append("3") }
            if (val & 0b00001000) != 0 { dots.append("4") }
            if (val & 0b00010000) != 0 { dots.append("5") }
            if (val & 0b00100000) != 0 { dots.append("6") }
            
            if dots.isEmpty { return "" }
            return dots.joined(separator: " ") + "점"
        }
        .filter { !$0.isEmpty }
        .joined(separator: ", ")
    }
}
