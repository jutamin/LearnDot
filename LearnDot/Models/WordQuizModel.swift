//
//  WordQuizModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/27/25.
//

import Foundation
import KorToBraille

struct QuizData {
    let brailleText: String // 점자 텍스트 (실제로는 점자 이미지나 점형 패턴)
    let correctAnswer: String
    let options: [String]
}

struct BrailleWord {
    let korean: String
    let braillePattern: String
    
    // KorToBraille을 사용하여 한글 단어들로부터 점자 패턴을 생성하는 편의 이니셜라이저
    init(korean: String) {
        self.korean = korean
        self.braillePattern = KorToBraille.korTranslate(korean)
    }
    
    // 미리 계산된 점자 패턴을 직접 지정하는 이니셜라이저 (커스터마이징 필요시)
    init(korean: String, braillePattern: String) {
        self.korean = korean
        self.braillePattern = braillePattern
    }
}

