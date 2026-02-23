//
//  WordQuizModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/27/25.
//

import Foundation
import KorToBraille

struct QuizData {
    let brailleText: String
    let correctAnswer: String
    let options: [String]
}

struct BrailleWord {
    let korean: String
    let braillePattern: String
    let description: String?
    
    init(korean: String, description: String? = nil) {
        self.korean = korean
        self.braillePattern = KorToBraille.korTranslate(korean)
        self.description = description
    }
    
    init(korean: String, braillePattern: String, description: String? = nil) {
         self.korean = korean
         self.braillePattern = braillePattern
         self.description = description
     }
}

