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
        generateQuize()
    }
    
    func generateQuize() {
        isLoading = true
        let sampleWords = getSampleWords(for: level, category: category)
        
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
    
    
    private func getSampleWords(for level: DifficultyLevel, category: WordCategory) -> [BrailleWord] {
        switch category {
        case .food:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "사과"),
                    BrailleWord(korean: "포도"),
                    BrailleWord(korean: "귤"),
                    BrailleWord(korean: "딸기"),
                    BrailleWord(korean: "바나나"),
                    BrailleWord(korean: "수박"),
                    BrailleWord(korean: "배"),
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
                    BrailleWord(korean: "여자"),
                    BrailleWord(korean: "화장실"),
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
                    BrailleWord(korean: "경기"),
                    BrailleWord(korean: "대전"),
                    BrailleWord(korean: "부산"),
                    BrailleWord(korean: "인천"),
                    BrailleWord(korean: "광주"),
                    BrailleWord(korean: "울산"),
                    BrailleWord(korean: "제주")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "서울역"),
                    BrailleWord(korean: "공릉역"),
                    BrailleWord(korean: "부산역"),
                    BrailleWord(korean: "동대구역"),
                    BrailleWord(korean: "수서역"),
                    BrailleWord(korean: "용산역"),
                    BrailleWord(korean: "김포공항"),
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
                    BrailleWord(korean: "밝기")
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
                    BrailleWord(korean: "데이터")
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
                    BrailleWord(korean: "비밀번호")
                ]
            }
        }
    }
}

