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

//struct WordQuiz: Identifiable, Hashable {
//    let id = UUID()
//    let braille: String
//    let correctAnswer: String
//    let options: [String]
//    //    let level: DifficultyLevel
//    //    let category: WordCategory
//    
//    static let sampleData: [WordQuiz] = [
//        WordQuiz(braille: "⠁", correctAnswer: "물", options: ["밥", "물", "쌀", "죽"]),
//        WordQuiz(braille: "⠃", correctAnswer: "돈까스", options: ["밥", "돈까스", "쌀", "죽"]),
//        WordQuiz(braille: "⠉", correctAnswer: "순두부찌개", options: ["밥", "순두부찌개", "쌀", "죽"])
//    ]
//}
