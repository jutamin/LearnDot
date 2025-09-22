//
//  BasicQuizViewModel.swift
//  LearnDot
//
//  Created by juyeun on 9/22/25.
//

import Foundation

@Observable
class BasicQuizViewModel {
    private let unit: BasicUnit
    
    var currentQuiz: QuizData?
    var isLoading = false
    
    init(unit: BasicUnit) {
        self.unit = unit
        generateQuize()
    }
    
    func generateQuize() {
        isLoading = true
        let sampleWords = getSampleWords(for: unit)
        
        guard let correctWord = sampleWords.randomElement() else {
            isLoading = false
            return
        }
        
        // 오답 선택지 생성
        var options = [correctWord.korean]
        let otherWords = sampleWords.filter { $0.korean != correctWord.korean }
        
        while options.count < 4 && !otherWords.isEmpty {
            if let randomWord = otherWords.randomElement(),
               !options.contains(randomWord.korean) {
                options.append(randomWord.korean)
            }
        }
        
        // 부족한 선택지가 있다면 더미 데이터 추가
        while options.count < 4 {
            let dummyWord = "선택지\(options.count)"
            if !options.contains(dummyWord) {
                options.append(dummyWord)
            }
        }
        
        options.shuffle()
        
        currentQuiz = QuizData(
            brailleText: correctWord.braillePattern,
            correctAnswer: correctWord.korean,
            options: options
        )
        
        isLoading = false
        
    }
    
    func checkAnswer(_ selectedAnswer: String) -> Bool {
        return selectedAnswer == currentQuiz?.correctAnswer
    }
    
    
    private func getSampleWords(for unit: BasicUnit) -> [BrailleWord] {
        switch unit {
        case .choseong:
            return [
                BrailleWord(korean: "ㄱ"),
                BrailleWord(korean: "ㄴ"),
                BrailleWord(korean: "ㄷ"),
                BrailleWord(korean: "ㄹ"),
                BrailleWord(korean: "ㅁ"),
                BrailleWord(korean: "ㅂ"),
                BrailleWord(korean: "ㅅ"),
                BrailleWord(korean: "ㅇ"),
                BrailleWord(korean: "ㅈ"),
                BrailleWord(korean: "ㅊ"),
                BrailleWord(korean: "ㅋ"),
                BrailleWord(korean: "ㅌ"),
                BrailleWord(korean: "ㅍ"),
                BrailleWord(korean: "ㅎ"),
                BrailleWord(korean: "ㄲ"),
                BrailleWord(korean: "ㄸ"),
                BrailleWord(korean: "ㅃ"),
                BrailleWord(korean: "ㅆ"),
                BrailleWord(korean: "ㅉ")
            ]
        case .jungseong:
            return [
                BrailleWord(korean: "ㅏ"),
                BrailleWord(korean: "ㅑ"),
                BrailleWord(korean: "ㅓ"),
                BrailleWord(korean: "ㅕ"),
                BrailleWord(korean: "ㅗ"),
                BrailleWord(korean: "ㅛ"),
                BrailleWord(korean: "ㅜ"),
                BrailleWord(korean: "ㅠ"),
                BrailleWord(korean: "ㅡ"),
                BrailleWord(korean: "ㅣ"),
                BrailleWord(korean: "ㅐ"),
                BrailleWord(korean: "ㅔ"),
                BrailleWord(korean: "ㅒ"),
                BrailleWord(korean: "ㅖ"),
                BrailleWord(korean: "ㅘ"),
                BrailleWord(korean: "ㅙ"),
                BrailleWord(korean: "ㅚ"),
                BrailleWord(korean: "ㅝ"),
                BrailleWord(korean: "ㅞ"),
                BrailleWord(korean: "ㅟ"),
                BrailleWord(korean: "ㅢ")
            ]
        case .jongseong:
            return [
                BrailleWord(korean: "ㄱ"),
                BrailleWord(korean: "ㄴ"),
                BrailleWord(korean: "ㄷ"),
                BrailleWord(korean: "ㄹ"),
                BrailleWord(korean: "ㅁ"),
                BrailleWord(korean: "ㅂ"),
                BrailleWord(korean: "ㅇ"),
                BrailleWord(korean: "ㄲ"),
                BrailleWord(korean: "ㄳ"),
                BrailleWord(korean: "ㄵ"),
                BrailleWord(korean: "ㄶ"),
                BrailleWord(korean: "ㄺ"),
                BrailleWord(korean: "ㄻ"),
                BrailleWord(korean: "ㄼ"),
                BrailleWord(korean: "ㄽ"),
                BrailleWord(korean: "ㄾ"),
                BrailleWord(korean: "ㄿ"),
                BrailleWord(korean: "ㅀ"),
                BrailleWord(korean: "ㅄ"),
                BrailleWord(korean: "ㅆ")
            ]
        }
    }
}
