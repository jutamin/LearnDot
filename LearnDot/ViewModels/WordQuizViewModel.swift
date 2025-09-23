//
//  WordQuizViewModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import Foundation

@Observable
class WordQuizViewModel {
    private let level: DifficultyLevel
    private let category: WordCategory
    
    var currentQuiz: QuizData?
    var isLoading = false
    
    init(level: DifficultyLevel, category: WordCategory) {
        self.level = level
        self.category = category
        generateQuiz()
    }
    
    /// 퀴즈 생성
    /// - Parameters:
    ///   - correctWord: 미리 정답을 지정할 수도 있음 (nil이면 랜덤)
    ///   - useBitwise: true면 점자 비트 기반 유사도 비교, false면 기본 문자열 비교
    func generateQuiz(correctWord: BrailleWord? = nil, useBitwise: Bool = true) {
        isLoading = true
        let sampleWords = getSampleWords(for: level, category: category)
        guard !sampleWords.isEmpty else {
            isLoading = false
            return
        }
        
        // 정답 선택
        let answerWord = correctWord ?? sampleWords.randomElement()!
        
        // 후보 오답 생성
        let otherWords = sampleWords.filter { $0.korean != answerWord.korean }
        var similarWords: [BrailleWord]
        if useBitwise {
            similarWords = generateSimilarOptionsBitwise(correctWord: answerWord, from: otherWords, count: 3)
        } else {
            similarWords = getSimilarOptions(correctWord: answerWord, candidates: otherWords)
        }
        
        // 옵션: 정답 + 유사 단어
        var options = [answerWord] + similarWords
        
        // 부족하면 무작위로 채우기
        while options.count < 4 {
            if let randomWord = sampleWords.randomElement(),
               !options.map(\.korean).contains(randomWord.korean) {
                options.append(randomWord)
            }
        }
        
        options.shuffle()
        
        currentQuiz = QuizData(
            brailleText: answerWord.braillePattern,
            correctAnswer: answerWord.korean,
            options: options.map { $0.korean }
        )
        
        isLoading = false
    }
    
    func checkAnswer(_ selectedAnswer: String) -> Bool {
        return selectedAnswer == currentQuiz?.correctAnswer
    }
    
    // MARK: - 비트 기반 유사 단어 생성
    private func generateSimilarOptionsBitwise(correctWord: BrailleWord, from words: [BrailleWord], count: Int = 3) -> [BrailleWord] {
        func brailleToBits(_ braille: String) -> [Int] {
            return braille.map { $0 == "⠀" ? 0 : 1 }
        }
        
        func hammingDistance(_ a: String, _ b: String) -> Int {
            let bitsA = brailleToBits(a)
            let bitsB = brailleToBits(b)
            let length = min(bitsA.count, bitsB.count)
            return zip(bitsA.prefix(length), bitsB.prefix(length)).map { $0 == $1 ? 0 : 1 }.reduce(0, +)
        }
        
        let sorted = words
            .map { ($0, hammingDistance(correctWord.braillePattern, $0.braillePattern)) }
            .sorted { $0.1 < $1.1 }
        
        return Array(sorted.prefix(count).map { $0.0 })
    }
    
    // MARK: - 기본 문자열 기반 유사 단어 생성 (간단한 더미)
    private func getSimilarOptions(correctWord: BrailleWord, candidates: [BrailleWord]) -> [BrailleWord] {
        // 단순 무작위 3개
        return Array(candidates.shuffled().prefix(3))
    }
    
    // MARK: - 샘플 단어
    private func getSampleWords(for level: DifficultyLevel, category: WordCategory) -> [BrailleWord] {
        switch category {
        case .food:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "사과"),
                    BrailleWord(korean: "석류"),
                    BrailleWord(korean: "파인애플"),
                    BrailleWord(korean: "포도"),
                    BrailleWord(korean: "귤"),
                    BrailleWord(korean: "딸기"),
                    BrailleWord(korean: "백도"),
                    BrailleWord(korean: "블루베리"),
                    BrailleWord(korean: "바나나"),
                    BrailleWord(korean: "수박"),
                    BrailleWord(korean: "배"),
                    BrailleWord(korean: "감"),
                    BrailleWord(korean: "밤"),
                    BrailleWord(korean: "복숭아")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "중식"),
                    BrailleWord(korean: "일식"),
                    BrailleWord(korean: "한식"),
                    BrailleWord(korean: "양식"),
                    BrailleWord(korean: "분식"),
                    BrailleWord(korean: "디저트"),
                    BrailleWord(korean: "음료수"),
                    BrailleWord(korean: "샐러드")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "아메리카노"),
                    BrailleWord(korean: "카페라떼"),
                    BrailleWord(korean: "에스프레소"),
                    BrailleWord(korean: "카푸치노"),
                    BrailleWord(korean: "티라미수"),
                    BrailleWord(korean: "마카롱"),
                    BrailleWord(korean: "브라우니"),
                    BrailleWord(korean: "젤라또")
                ]
            }
        case .restroom:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "남자"),
                    BrailleWord(korean: "남성용"),
                    BrailleWord(korean: "남녀공용"),
                    BrailleWord(korean: "여자"),
                    BrailleWord(korean: "여성용"),
                    BrailleWord(korean: "여아용"),
                    BrailleWord(korean: "화장실"),
                    BrailleWord(korean: "화장대"),
                    BrailleWord(korean: "화장품코너"),
                    BrailleWord(korean: "유아용"),
                    BrailleWord(korean: "장애인"),
                    BrailleWord(korean: "비상벨"),
                    BrailleWord(korean: "손잡이"),
                    BrailleWord(korean: "비누")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "세면대"),
                    BrailleWord(korean: "휴지통"),
                    BrailleWord(korean: "건조기"),
                    BrailleWord(korean: "청소도구"),
                    BrailleWord(korean: "손세정제"),
                    BrailleWord(korean: "휴대용"),
                    BrailleWord(korean: "자동문"),
                    BrailleWord(korean: "여성용")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "장애인 호출 버튼"),
                    BrailleWord(korean: "잠금 장치"),
                    BrailleWord(korean: "비상벨"),
                    BrailleWord(korean: "손잡이"),
                    BrailleWord(korean: "경고등"),
                    BrailleWord(korean: "센서 감지기"),
                    BrailleWord(korean: "비상 출입문"),
                    BrailleWord(korean: "긴급 상황")
                ]
            }
        case .transport:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "서울"),
                    BrailleWord(korean: "성남"),
                    BrailleWord(korean: "성신여대"),
                    BrailleWord(korean: "경기"),
                    BrailleWord(korean: "고양"),
                    BrailleWord(korean: "광명"),
                    BrailleWord(korean: "대전"),
                    BrailleWord(korean: "대구"),
                    BrailleWord(korean: "덕정"),
                    BrailleWord(korean: "부산"),
                    BrailleWord(korean: "부평"),
                    BrailleWord(korean: "부천"),
                    BrailleWord(korean: "인천"),
                    BrailleWord(korean: "일산"),
                    BrailleWord(korean: "의정부"),
                    BrailleWord(korean: "광주"),
                    BrailleWord(korean: "울산"),
                    BrailleWord(korean: "제주")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "서울역"),
                    BrailleWord(korean: "성신여대역"),
                    BrailleWord(korean: "석계역"),
                    BrailleWord(korean: "공릉역"),
                    BrailleWord(korean: "고속터미널역"),
                    BrailleWord(korean: "관악역"),
                    BrailleWord(korean: "부산역"),
                    BrailleWord(korean: "동대구역"),
                    BrailleWord(korean: "수서역"),
                    BrailleWord(korean: "용산역"),
                    BrailleWord(korean: "김포공항"),
                    BrailleWord(korean: "인천"),
                    BrailleWord(korean: "일산"),
                    BrailleWord(korean: "의정부"),
                    BrailleWord(korean: "청량리")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "출입문"),
                    BrailleWord(korean: "종착역"),
                    BrailleWord(korean: "정류장"),
                    BrailleWord(korean: "운행시간"),
                    BrailleWord(korean: "노선도"),
                    BrailleWord(korean: "차량번호"),
                    BrailleWord(korean: "정차위치"),
                    BrailleWord(korean: "승차위치"),
                    BrailleWord(korean: "승차권")
                ]
            }
        case .medicine:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "약"),
                    BrailleWord(korean: "물약"),
                    BrailleWord(korean: "알약"),
                    BrailleWord(korean: "연고"),
                    BrailleWord(korean: "주사"),
                    BrailleWord(korean: "밴드"),
                    BrailleWord(korean: "파스"),
                    BrailleWord(korean: "기침약")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "감기약"),
                    BrailleWord(korean: "소화제"),
                    BrailleWord(korean: "해열제"),
                    BrailleWord(korean: "진통제"),
                    BrailleWord(korean: "항생제"),
                    BrailleWord(korean: "비타민"),
                    BrailleWord(korean: "영양제"),
                    BrailleWord(korean: "소독약")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "복약안내"),
                    BrailleWord(korean: "주의사항"),
                    BrailleWord(korean: "의사소견"),
                    BrailleWord(korean: "처방전"),
                    BrailleWord(korean: "복용시간"),
                    BrailleWord(korean: "금기사항"),
                    BrailleWord(korean: "약물반응"),
                    BrailleWord(korean: "장기복용")
                ]
            }
        case .electronics:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "전원"),
                    BrailleWord(korean: "볼륨"),
                    BrailleWord(korean: "전원"),
                    BrailleWord(korean: "볼륨"),
                    BrailleWord(korean: "충전"),
                    BrailleWord(korean: "화면"),
                    BrailleWord(korean: "버튼"),
                    BrailleWord(korean: "리모컨"),
                    BrailleWord(korean: "소리"),
                    BrailleWord(korean: "밝기"),
                    BrailleWord(korean: "스피커"),
                    BrailleWord(korean: "마이크"),
                    BrailleWord(korean: "스위치"),
                ]
            case .normal:
                return [
                    BrailleWord(korean: "설정"),
                    BrailleWord(korean: "메뉴"),
                    BrailleWord(korean: "입력"),
                    BrailleWord(korean: "절전모드"),
                    BrailleWord(korean: "진동"),
                    BrailleWord(korean: "음소거"),
                    BrailleWord(korean: "배경화면"),
                    BrailleWord(korean: "데이터"),
                    BrailleWord(korean: "사운드"),
                    BrailleWord(korean: "키보드"),
                    BrailleWord(korean: "배터리"),
                    BrailleWord(korean: "아이콘")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "무선연결"),
                    BrailleWord(korean: "블루투스"),
                    BrailleWord(korean: "소프트웨어"),
                    BrailleWord(korean: "운영체제"),
                    BrailleWord(korean: "업데이트"),
                    BrailleWord(korean: "시스템복원"),
                    BrailleWord(korean: "네트워크"),
                    BrailleWord(korean: "와이파이"),
                    BrailleWord(korean: "스마트폰"),
                    BrailleWord(korean: "노트북"),
                    BrailleWord(korean: "비밀번호")
                ]
            }
        }
    }
}
