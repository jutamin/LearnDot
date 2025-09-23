//
//  PunctuationQuizViewModel.swift
//  LearnDot
//
//  Created by 신혜연 on 6/11/25.
//

import Foundation

class PunctuationQuizViewModel: ObservableObject {
    
    let punctuationData: [BrailleWord] = [
        BrailleWord(korean: "온점 (.)", braillePattern: "⠲", description: "문장 끝을 마무리할 때 사용"),
        BrailleWord(korean: "물음표 (?)", braillePattern: "⠦", description: "의문을 나타낼 때 사용"),
        BrailleWord(korean: "느낌표 (!)", braillePattern: "⠖", description: "강조하거나 감탄을 나타낼 때 사용"),
        BrailleWord(korean: "반점 (,)", braillePattern: "⠐", description: "문장 안에서 잠깐 쉬거나 나열할 때 사용"),
        BrailleWord(korean: "붙임표 (-)", braillePattern: "⠤", description: "두 단어를 이어주거나 연결할 때 사용"),
        BrailleWord(korean: "빼기 (-)", braillePattern: "⠔", description: "뺄셈이나 음수를 나타낼 때 사용"),
        BrailleWord(korean: "줄표 (—)", braillePattern: "⠤⠤", description: "문장 내 구분이나 강조를 위해 사용"),
        BrailleWord(korean: "물결표 (~)", braillePattern: "⠈⠔", description: "길이나 범위를 나타낼 때 사용"),
        BrailleWord(korean: "별표 (*)", braillePattern: "⠐⠔", description: "주석이나 강조 표시할 때 사용"),
        BrailleWord(korean: "여는 큰따옴표 (“)", braillePattern: "⠠⠦", description: "말이나 글을 인용할 때 시작"),
        BrailleWord(korean: "닫는 큰따옴표 (”)", braillePattern: "⠴", description: "말이나 글을 인용할 때 끝"),
        BrailleWord(korean: "여는 작은따옴표 (‘)", braillePattern: "⠠⠦", description: "작은 인용이나 강조를 시작할 때"),
        BrailleWord(korean: "닫는 작은따옴표 (’)", braillePattern: "⠴⠄", description: "작은 인용이나 강조를 끝낼 때"),
        BrailleWord(korean: "쌍점 (:)", braillePattern: "⠐⠂", description: "목록이나 설명을 시작할 때 사용"),
        BrailleWord(korean: "세미콜론 (;)", braillePattern: "⠰⠆", description: "두 문장을 연결하거나 나열할 때 사용"),
        BrailleWord(korean: "줄임표 (…)", braillePattern: "⠠⠠⠠", description: "문장의 일부를 생략하거나 말을 끊어 생략할 때 사용")
    ]
    
    @Published var currentQuiz: BrailleWord? = nil
    var shouldGenerateNewQuiz: Bool = false
    
    init() {
        generateNewQuiz()
    }
    
    func generateNewQuiz() {
        guard !punctuationData.isEmpty else { return }

        var newQuiz: BrailleWord
        repeat {
            newQuiz = punctuationData.randomElement()!
        } while newQuiz.korean == currentQuiz?.korean

        currentQuiz = newQuiz
        shouldGenerateNewQuiz = false
    }
    
    func prepareNewQuizIfNeeded() {
        if shouldGenerateNewQuiz || currentQuiz == nil {
            generateNewQuiz()
            shouldGenerateNewQuiz = false
        }
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
