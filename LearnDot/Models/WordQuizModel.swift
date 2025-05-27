//
//  WordQuizModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/27/25.
//

import Foundation

struct WordQuiz: Identifiable, Hashable {
    let id = UUID()
    let braille: String
    let correctAnswer: String
    let options: [String]
    //    let level: DifficultyLevel
    //    let category: WordCategory
    
    static let sampleData: [WordQuiz] = [
        WordQuiz(braille: "⠁", correctAnswer: "물", options: ["밥", "물", "쌀", "죽"]),
        WordQuiz(braille: "⠃", correctAnswer: "돈까스", options: ["밥", "돈까스", "쌀", "죽"]),
        WordQuiz(braille: "⠉", correctAnswer: "순두부찌개", options: ["밥", "순두부찌개", "쌀", "죽"])
    ]
}

//struct WordQuizData {
//    static let all: [WordQuiz] = [
//        // 예시: 각 카테고리와 레벨마다 1개씩 (총 5레벨 × 3단계 = 15개)
//        WordQuiz(braille: "⠁", correctAnswer: "밥", options: ["밥", "국", "물", "고기"], level: .easy, category: .food),
//        WordQuiz(braille: "⠃", correctAnswer: "국", options: ["김치", "밥", "국", "물"], level: .normal, category: .food),
//        WordQuiz(braille: "⠉", correctAnswer: "고기", options: ["고기", "쌀", "과일", "채소"], level: .hard, category: .food),
//
//        WordQuiz(braille: "⠋", correctAnswer: "화장실", options: ["화장실", "엘리베이터", "출입구", "계단"], level: .easy, category: .restroom),
//        WordQuiz(braille: "⠛", correctAnswer: "계단", options: ["계단", "문", "복도", "출입구"], level: .normal, category: .restroom),
//        WordQuiz(braille: "⠓", correctAnswer: "안내", options: ["출입구", "안내", "닫힘", "개방"], level: .hard, category: .restroom),
//
//        WordQuiz(braille: "⠊", correctAnswer: "버스", options: ["버스", "지하철", "기차", "택시"], level: .easy, category: .transport),
//        WordQuiz(braille: "⠚", correctAnswer: "지하철", options: ["버스", "지하철", "환승", "요금"], level: .normal, category: .transport),
//        WordQuiz(braille: "⠛", correctAnswer: "환승", options: ["요금", "표", "환승", "기차"], level: .hard, category: .transport),
//
//        WordQuiz(braille: "⠜", correctAnswer: "약", options: ["약", "병원", "약국", "물"], level: .easy, category: .medicine),
//        WordQuiz(braille: "⠝", correctAnswer: "약국", options: ["약국", "의사", "병원", "환자"], level: .normal, category: .medicine),
//        WordQuiz(braille: "⠞", correctAnswer: "복용", options: ["복용", "처방", "약", "금지"], level: .hard, category: .medicine),
//
//        WordQuiz(braille: "⠟", correctAnswer: "전원", options: ["전원", "볼륨", "재생", "정지"], level: .easy, category: .electronics),
//        WordQuiz(braille: "⠠", correctAnswer: "볼륨", options: ["소리", "볼륨", "음소거", "채널"], level: .normal, category: .electronics),
//        WordQuiz(braille: "⠡", correctAnswer: "입력", options: ["입력", "출력", "설정", "초기화"], level: .hard, category: .electronics),
//    ]
//}
