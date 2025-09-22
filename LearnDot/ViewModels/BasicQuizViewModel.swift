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
    
//    private func getSampleWords(for unit: BasicUnit) -> [String] {
//        switch unit {
//        case .choseong:
//            return [
//                kor_cho["ㄱ"] ?? "", // 초성 'ㄱ' 점자: "⠈"
//                kor_cho["ㄴ"] ?? "", // 초성 'ㄴ' 점자: "⠉"
//                kor_cho["ㄷ"] ?? "", // 초성 'ㄷ' 점자: "⠊"
//                kor_cho["ㄹ"] ?? "", // 초성 'ㄹ' 점자: "⠐"
//                kor_cho["ㅁ"] ?? "", // 초성 'ㅁ' 점자: "⠑"
//                kor_cho["ㅂ"] ?? "", // 초성 'ㅂ' 점자: "⠘"
//                kor_cho["ㅅ"] ?? "", // 초성 'ㅅ' 점자: "⠠"
//                kor_cho["ㅇ"] ?? "", // 초성 'ㅇ' 점자: " "
//                kor_cho["ㅈ"] ?? "", // 초성 'ㅈ' 점자: "⠨"
//                kor_cho["ㅊ"] ?? "", // 초성 'ㅊ' 점자: "⠰"
//                kor_cho["ㅋ"] ?? "", // 초성 'ㅋ' 점자: "⠋"
//                kor_cho["ㅌ"] ?? "", // 초성 'ㅌ' 점자: "⠓"
//                kor_cho["ㅍ"] ?? "", // 초성 'ㅍ' 점자: "⠙"
//                kor_cho["ㅎ"] ?? "", // 초성 'ㅎ' 점자: "⠚"
//                kor_cho["ㄲ"] ?? "", // 초성 'ㄲ' 점자: "⠠⠈"
//                kor_cho["ㄸ"] ?? "", // 초성 'ㄸ' 점자: "⠠⠊"
//                kor_cho["ㅃ"] ?? "", // 초성 'ㅃ' 점자: "⠠⠘"
//                kor_cho["ㅆ"] ?? "", // 초성 'ㅆ' 점자: "⠠⠠"
//                kor_cho["ㅉ"] ?? ""  // 초성 'ㅉ' 점자: "⠠⠨"
//            ]
//        case .jungseong:
//            return [
//                kor_jung["ㅏ"] ?? "", // 중성 'ㅏ' 점자: "⠣"
//                kor_jung["ㅑ"] ?? "", // 중성 'ㅑ' 점자: "⠜"
//                kor_jung["ㅓ"] ?? "", // 중성 'ㅓ' 점자: "⠎"
//                kor_jung["ㅕ"] ?? "", // 중성 'ㅕ' 점자: "⠱"
//                kor_jung["ㅗ"] ?? "", // 중성 'ㅗ' 점자: "⠥"
//                kor_jung["ㅛ"] ?? "", // 중성 'ㅛ' 점자: "⠬"
//                kor_jung["ㅜ"] ?? "", // 중성 'ㅜ' 점자: "⠍"
//                kor_jung["ㅠ"] ?? "", // 중성 'ㅠ' 점자: "⠩"
//                kor_jung["ㅡ"] ?? "", // 중성 'ㅡ' 점자: "⠪"
//                kor_jung["ㅣ"] ?? "", // 중성 'ㅣ' 점자: "⠕"
//                kor_jung["ㅐ"] ?? "", // 중성 'ㅐ' 점자: "⠗"
//                kor_jung["ㅔ"] ?? "", // 중성 'ㅔ' 점자: "⠝"
//                kor_jung["ㅒ"] ?? "", // 중성 'ㅒ' 점자: "⠜⠗"
//                kor_jung["ㅖ"] ?? "", // 중성 'ㅖ' 점자: "⠌"
//                kor_jung["ㅘ"] ?? "", // 중성 'ㅘ' 점자: "⠧"
//                kor_jung["ㅙ"] ?? "", // 중성 'ㅙ' 점자: "⠧⠗"
//                kor_jung["ㅚ"] ?? "", // 중성 'ㅚ' 점자: "⠽"
//                kor_jung["ㅝ"] ?? "", // 중성 'ㅝ' 점자: "⠏"
//                kor_jung["ㅞ"] ?? "", // 중성 'ㅞ' 점자: "⠏⠗"
//                kor_jung["ㅟ"] ?? "", // 중성 'ㅟ' 점자: "⠍⠗"
//                kor_jung["ㅢ"] ?? ""  // 중성 'ㅢ' 점자: "⠺"
//            ]
//        case .jongseong:
//            return [
//                kor_jong["ㄱ"] ?? "", // 종성 'ㄱ' 점자: "⠁"
//                kor_jong["ㄳ"] ?? "", // 종성 'ㄳ' 점자: "⠁⠄"
//                kor_jong["ㄴ"] ?? "", // 종성 'ㄴ' 점자: "⠒"
//                kor_jong["ㄵ"] ?? "", // 종성 'ㄵ' 점자: "⠒⠅"
//                kor_jong["ㄶ"] ?? "", // 종성 'ㄶ' 점자: "⠒⠴"
//                kor_jong["ㄷ"] ?? "", // 종성 'ㄷ' 점자: "⠔"
//                kor_jong["ㄹ"] ?? "", // 종성 'ㄹ' 점자: "⠂"
//                kor_jong["ㄺ"] ?? "", // 종성 'ㄺ' 점자: "⠂⠁"
//                kor_jong["ㄻ"] ?? "", // 종성 'ㄻ' 점자: "⠂⠢"
//                kor_jong["ㄼ"] ?? "", // 종성 'ㄼ' 점자: "⠂⠃"
//                kor_jong["ㄽ"] ?? "", // 종성 'ㄽ' 점자: "⠂⠄"
//                kor_jong["ㄾ"] ?? "", // 종성 'ㄾ' 점자: "⠂⠦"
//                kor_jong["ㄿ"] ?? "", // 종성 'ㄿ' 점자: "⠂⠲"
//                kor_jong["ㅀ"] ?? "", // 종성 'ㅀ' 점자: "⠂⠴"
//                kor_jong["ㅁ"] ?? "", // 종성 'ㅁ' 점자: "⠢"
//                kor_jong["ㅂ"] ?? "", // 종성 'ㅂ' 점자: "⠃"
//                kor_jong["ㅄ"] ?? "", // 종성 'ㅄ' 점자: "⠃⠄"
//                kor_jong["ㅅ"] ?? "", // 종성 'ㅅ' 점자: "⠄"
//                kor_jong["ㅇ"] ?? "", // 종성 'ㅇ' 점자: "⠶"
//                kor_jong["ㅈ"] ?? "", // 종성 'ㅈ' 점자: "⠅"
//                kor_jong["ㅊ"] ?? "", // 종성 'ㅊ' 점자: "⠆"
//                kor_jong["ㅋ"] ?? "", // 종성 'ㅋ' 점자: "⠖"
//                kor_jong["ㅌ"] ?? "", // 종성 'ㅌ' 점자: "⠦"
//                kor_jong["ㅍ"] ?? "", // 종성 'ㅍ' 점자: "⠲"
//                kor_jong["ㅎ"] ?? "", // 종성 'ㅎ' 점자: "⠴"
//                kor_jong["ㄲ"] ?? "", // 종성 'ㄲ' 점자: "⠁⠁"
//                kor_jong["ㅆ"] ?? ""  // 종성 'ㅆ' 점자: "⠌"
//            ]
//        }
//    }
}
