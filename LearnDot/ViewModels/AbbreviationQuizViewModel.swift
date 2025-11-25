//
//  AbbreviationQuizViewModel.swift
//  LearnDot
//
//  Created by juyeun on 11/18/25.
//

import Foundation

enum AbbreviationUnit {
    case contraction
    case abbreviations
}

@Observable
class AbbreviationQuizViewModel {
    private let unit: AbbreviationUnit
    
    private let contractionWords: [String] = [
        "가지","나비","다리미","라디오","고구마","바느질","사위","아궁이","도자기","기차","카메라","실타래","파도","하루","강산","낮잠","단란","만찬","안방","바캉스","갈비탕","판소리","합창","까마귀","깜깜하다","따님","딱따구리","오빠","빵집","싸구려","찹쌀","짜장","짱구","억새","추억","언어","격언","얼룩","하얼빈","연필","자연","열매","가열","영어","환영","옥수수","가옥","온도","오리온","옹고집","새옹지마","운동장","행운","울타리","겨울","은하수","양은","을지로","가을","인내","거인","것이다","이것","덕망","기적","꺾다","넋","건전지","개천절","얹다","벌레","옷걸이","얽다","젊다","넓다","변화","수련","별자리","헌혈","엷다","평화","안녕","복덕방","가곡","볶다","논두렁","용돈","동그라미","탁구공","순두부","숭례문","불고기","일출","붉다","굶다","훑다","근로","마흔","끊다","글씨","구슬","긁다","읊다","끓다","진실","어린이","하겄다","까치","깡충깡충","싸리나무","쌍둥이","힘껏","마음껏","성가","말썽","정성","어정쩡","청년","얄라셩"
    ]
    
    var currentQuiz: QuizData?
    var isLoading = false
    
    init(unit: AbbreviationUnit) {
        self.unit = unit
        generateQuiz()
    }
    
    private func makeOptions(from sampleWords: [BrailleWord], correctWord: BrailleWord) -> [String] {
        var optionSet: Set<String> = [correctWord.korean]
        let otherWords = sampleWords.filter { $0.korean != correctWord.korean }

        while optionSet.count < 4, let randomWord = otherWords.randomElement() {
            optionSet.insert(randomWord.korean)
        }

        while optionSet.count < 4 {
            optionSet.insert("선택지\(optionSet.count)")
        }

        return Array(optionSet).shuffled()
    }
    
    func generateQuiz() {
        isLoading = true
        let sampleWords = getSampleWords(for: unit)
        
        guard let correctWord = sampleWords.randomElement() else {
            isLoading = false
            return
        }
        
        let options = makeOptions(from: sampleWords, correctWord: correctWord)
        
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
    
    private func getSampleWords(for unit: AbbreviationUnit) -> [BrailleWord] {
        switch unit {
        case .contraction:
            return contractionWords.map { BrailleWord(korean: $0) }
        case .abbreviations:
            return kor_abbreviations.map { BrailleWord(korean: $0.key, braillePattern: $0.value) }
        }
    }
}
