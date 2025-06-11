//
//  PunctuationQuizViewModel.swift
//  LearnDot
//
//  Created by 신혜연 on 6/11/25.
//

import Foundation

class PunctuationQuizViewModel: ObservableObject {
    
    let punctuationData: [BrailleWord] = [
        BrailleWord(korean: "온점 (.)", braillePattern: "⠲"),
        BrailleWord(korean: "물음표 (?)", braillePattern: "⠦"),
        BrailleWord(korean: "느낌표 (!)", braillePattern: "⠖"),
        BrailleWord(korean: "반점 (,)", braillePattern: "⠐"),
        BrailleWord(korean: "붙임표 (-)", braillePattern: "⠤"),
        BrailleWord(korean: "빼기 (-)", braillePattern: "⠔"),
        BrailleWord(korean: "줄표 (—)", braillePattern: "⠤⠤"),
        BrailleWord(korean: "물결표 (~)", braillePattern: "⠈⠔"),
        BrailleWord(korean: "별표 (*)", braillePattern: "⠐⠔"),
        BrailleWord(korean: "여는 큰따옴표 (“)", braillePattern: "⠠⠦"),
        BrailleWord(korean: "닫는 큰따옴표 (”)", braillePattern: "⠴"),
        BrailleWord(korean: "여는 작은따옴표 (‘)", braillePattern: "⠠⠦"),
        BrailleWord(korean: "닫는 작은따옴표 (’)", braillePattern: "⠴⠄"),
        BrailleWord(korean: "쌍점 (:)", braillePattern: "⠐⠂"),
        BrailleWord(korean: "세미콜론 (;)", braillePattern: "⠰⠆"),
        BrailleWord(korean: "줄임표 (…)", braillePattern: "⠠⠠⠠")
    ]
    
    @Published var currentQuiz: BrailleWord? = nil
    
    init() {
        generateNewQuiz()
    }
    
    func generateNewQuiz() {
        currentQuiz = punctuationData.randomElement()
    }
    
    func isAnswerCorrect(selectedDotsArray: [[Int]]) -> Bool {
        guard let correctPattern = currentQuiz?.braillePattern else { return false }
        
        let correctDotArrays = convertBraillePatternToDotArrays(correctPattern)
        
        print("🔍 정답 패턴: \(correctPattern)")
        print("✅ 정답 dot 배열: \(correctDotArrays)")
        print("📝 입력 dot 배열: \(selectedDotsArray)")
        
        if selectedDotsArray.count != correctDotArrays.count { return false }
        
        for (inputDots, correctDots) in zip(selectedDotsArray, correctDotArrays) {
            if Set(inputDots) != Set(correctDots) {
                print("❌ 불일치: \(inputDots) vs \(correctDots)")
                return false
            }
        }
        return true
    }
    
    func convertBraillePatternToDotArrays(_ pattern: String) -> [[Int]] {
        pattern.map { brailleChar in
            let scalar = brailleChar.unicodeScalars.first!.value
            let bits = Int(scalar - 0x2800)
            var activeDots: [Int] = []
            for i in 0..<6 {
                if (bits & (1 << i)) != 0 {
                    activeDots.append(i+1)
                }
            }
            return activeDots
        }
    }
}
