//
//  NumberQuizViewModel.swift
//  LearnDot
//
//  Created by 신혜연 on 11/17/25.
//

import Foundation
import KorToBraille

@Observable
class NumberQuizViewModel {
    
    var currentQuiz: QuizData?
    var isLoading = false
    
    init() {
        generateQuize()
    }
    
    func generateQuize() {
        isLoading = true
        let sampleWords = getSampleNumbers()
        
        guard let correctWord = sampleWords.randomElement() else {
            isLoading = false
            return
        }
        
        var options = [correctWord.korean]
        var otherWords = sampleWords.filter { $0.korean != correctWord.korean }
        
        while options.count < 4 && !otherWords.isEmpty {
            if let randomWord = otherWords.randomElement() {
                if !options.contains(randomWord.korean) {
                    options.append(randomWord.korean)
                }
                otherWords.removeAll { $0.korean == randomWord.korean }
            }
        }
        
        while options.count < 4 && !sampleWords.isEmpty {
            if let randomWord = sampleWords.randomElement(), !options.contains(randomWord.korean) {
                options.append(randomWord.korean)
            } else if options.count == sampleWords.count {
                break
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
    
    
    private func getSampleNumbers() -> [BrailleWord] {
        var numbersSet: Set<String> = []
        
        for i in 0...9 {
            numbersSet.insert(String(i))
        }

        while numbersSet.count < 25 {
            let randomNum = String(Int.random(in: 10...99))
            numbersSet.insert(randomNum)
        }
        
        while numbersSet.count < 35 {
            let randomNum = String(Int.random(in: 100...999))
            numbersSet.insert(randomNum)
        }
        
        let numbers = Array(numbersSet)
        
        return numbers.map { BrailleWord(korean: $0) }
    }
}
