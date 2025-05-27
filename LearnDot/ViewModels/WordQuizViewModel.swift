//
//  WordQuizViewModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import Foundation

@Observable
class WordQuizViewModel {
    private var quizzes: [WordQuiz] = WordQuiz.sampleData.shuffled()
        var currentIndex: Int = 0

        var currentQuiz: WordQuiz {
            quizzes[currentIndex]
        }

        var isLastQuiz: Bool {
            currentIndex == quizzes.count - 1
        }

        func goToNextQuiz() {
            if !isLastQuiz {
                currentIndex += 1
            }
        }

        func isCorrect(answer: String) -> Bool {
            answer == currentQuiz.correctAnswer
        }}
