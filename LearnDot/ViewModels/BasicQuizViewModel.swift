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
            return kor_cho.map { BrailleWord(korean: $0.key, braillePattern: $0.value) }
        case .jungseong:
            return kor_jung.map { BrailleWord(korean: $0.key, braillePattern: $0.value) }
        case .jongseong:
            return kor_jong.map { BrailleWord(korean: $0.key, braillePattern: $0.value) }
        }
    }
}
