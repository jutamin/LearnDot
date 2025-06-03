//
//  WordQuizModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/27/25.
//

import Foundation

struct QuizData {
    let brailleText: String // 점자 텍스트 (실제로는 점자 이미지나 점형 패턴)
    let correctAnswer: String
    let options: [String]
}

struct BrailleWord {
    let korean: String
    let braillePattern: String
}

