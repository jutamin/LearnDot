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
        // 실제 앱에서는 여기서 점자 데이터베이스나 API를 호출
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
                    BrailleWord(korean: "사과", braillePattern: "⠎⠁⠈⠁"),
                    BrailleWord(korean: "포도", braillePattern: "⠏⠕⠈⠕"),
                    BrailleWord(korean: "귤", braillePattern: "⠨⠥⠇"),
                    BrailleWord(korean: "딸기", braillePattern: "⠈⠁⠇⠅⠊"),
                    BrailleWord(korean: "바나나", braillePattern: "⠃⠁⠝⠁⠝⠁"),
                    BrailleWord(korean: "오렌지", braillePattern: "⠕⠗⠑⠝⠐⠊"),
                    BrailleWord(korean: "토마토", braillePattern: "⠞⠕⠍⠁⠞⠕"),
                    BrailleWord(korean: "복숭아", braillePattern: "⠃⠕⠅⠎⠥⠝⠁")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "중식", braillePattern: "⠨⠥⠝⠎⠊⠅"),
                    BrailleWord(korean: "일식", braillePattern: "⠊⠇⠎⠊⠅"),
                    BrailleWord(korean: "한식", braillePattern: "⠓⠁⠝⠎⠊⠅"),
                    BrailleWord(korean: "양식", braillePattern: "⠨⠁⠝⠎⠊⠅"),
                    BrailleWord(korean: "디저트", braillePattern: "⠙⠊⠐⠑⠗⠞"),
                    BrailleWord(korean: "음료", braillePattern: "⠕⠍⠗⠊⠕"),
                    BrailleWord(korean: "샐러드", braillePattern: "⠱⠑⠇⠇⠑⠙"),
                    BrailleWord(korean: "간식", braillePattern: "⠉⠁⠝⠎⠊⠅")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "아메리카노", braillePattern: "⠁⠍⠑⠗⠊⠅⠁⠝⠕"),
                    BrailleWord(korean: "카페라떼", braillePattern: "⠅⠁⠏⠑⠗⠁⠈⠑"),
                    BrailleWord(korean: "에스프레소", braillePattern: "⠑⠎⠏⠗⠑⠎⠕"),
                    BrailleWord(korean: "카푸치노", braillePattern: "⠅⠁⠏⠥⠉⠊⠝⠕"),
                    BrailleWord(korean: "티라미수", braillePattern: "⠞⠊⠗⠁⠍⠊⠎⠥"),
                    BrailleWord(korean: "마카롱", braillePattern: "⠍⠁⠅⠁⠗⠕⠝⠛"),
                    BrailleWord(korean: "브라우니", braillePattern: "⠃⠗⠁⠥⠝⠊"),
                    BrailleWord(korean: "젤라또", braillePattern: "⠚⠑⠇⠇⠁⠞⠞⠕")
                ]
            }
        case .restroom:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "남자", braillePattern: "⠝⠁⠍⠨⠁"),
                    BrailleWord(korean: "여자", braillePattern: "⠽⠕⠨⠁"),
                    BrailleWord(korean: "화장실", braillePattern: "⠓⠺⠁⠨⠁⠝⠎⠊⠇"),
                    BrailleWord(korean: "유아용", braillePattern: "⠽⠥⠁⠨⠕⠝"),
                    BrailleWord(korean: "장애인", braillePattern: "⠚⠁⠝⠛⠁⠑⠝"),
                    BrailleWord(korean: "비상벨", braillePattern: "⠃⠊⠎⠁⠝⠃⠑⠇"),
                    BrailleWord(korean: "손잡이", braillePattern: "⠎⠕⠝⠚⠁⠃⠊"),
                    BrailleWord(korean: "비누", braillePattern: "⠃⠊⠝⠥")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "세면대", braillePattern: "⠎⠑⠍⠑⠝⠈⠑"),
                    BrailleWord(korean: "휴지통", braillePattern: "⠓⠥⠨⠊⠞⠥⠝"),
                    BrailleWord(korean: "건조기", braillePattern: "⠛⠕⠝⠚⠕⠅⠊"),
                    BrailleWord(korean: "청소도구", braillePattern: "⠉⠓⠕⠝⠎⠕⠙⠕⠛⠥"),
                    BrailleWord(korean: "손세정제", braillePattern: "⠎⠕⠝⠎⠑⠚⠕⠝⠚⠑"),
                    BrailleWord(korean: "휴대용", braillePattern: "⠓⠥⠙⠁⠑⠕⠝"),
                    BrailleWord(korean: "자동문", braillePattern: "⠚⠁⠙⠕⠝⠍⠥⠝"),
                    BrailleWord(korean: "여성용", braillePattern: "⠽⠕⠎⠑⠝⠛⠕⠝")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "장애인 호출 버튼", braillePattern: "⠚⠁⠝⠛⠁⠊⠝ ⠓⠕⠊⠎⠥⠇ ⠃⠥⠞⠞⠕⠝"),
                    BrailleWord(korean: "잠금 장치", braillePattern: "⠚⠁⠍⠛⠥⠍ ⠚⠁⠝⠉⠓⠊"),
                    BrailleWord(korean: "비상벨", braillePattern: "⠃⠊⠎⠁⠝⠃⠑⠇"),
                    BrailleWord(korean: "손잡이", braillePattern: "⠎⠕⠝⠚⠁⠃⠊"),
                    BrailleWord(korean: "경고등", braillePattern: "⠅⠕⠗⠝⠊⠝⠛ ⠇⠊⠛⠓⠞"),
                    BrailleWord(korean: "센서 감지기", braillePattern: "⠎⠑⠝⠎⠕ ⠛⠁⠍⠚⠊⠅⠊"),
                    BrailleWord(korean: "비상 출입문", braillePattern: "⠃⠊⠎⠁⠝ ⠉⠓⠥⠇⠊⠍⠍⠥⠝"),
                    BrailleWord(korean: "긴급 상황", braillePattern: "⠛⠊⠝⠛⠥⠏ ⠎⠁⠝⠓⠁⠝")
                ]
            }
        case .transport:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "서울", braillePattern: "⠎⠕⠥⠇"),
                    BrailleWord(korean: "경기", braillePattern: "⠅⠽⠕⠝⠅⠊"),
                    BrailleWord(korean: "대전", braillePattern: "⠈⠑⠨⠕⠝"),
                    BrailleWord(korean: "부산", braillePattern: "⠃⠥⠎⠁⠝"),
                    BrailleWord(korean: "인천", braillePattern: "⠊⠝⠨⠕⠝"),
                    BrailleWord(korean: "광주", braillePattern: "⠅⠗⠁⠝⠨⠜"),
                    BrailleWord(korean: "울산", braillePattern: "⠥⠇⠎⠁⠝"),
                    BrailleWord(korean: "제주", braillePattern: "⠚⠔⠨⠜")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "서울역", braillePattern: "⠎⠕⠥⠇⠽⠕⠅"),
                    BrailleWord(korean: "공릉역", braillePattern: "⠅⠕⠝⠗⠥⠝⠽⠕⠅"),
                    BrailleWord(korean: "부산역", braillePattern: "⠃⠥⠎⠁⠝⠽⠕⠅"),
                    BrailleWord(korean: "동대구", braillePattern: "⠙⠕⠝⠅⠙⠑⠛⠕⠥"),
                    BrailleWord(korean: "수서역", braillePattern: "⠎⠥⠎⠓⠽⠕⠅"),
                    BrailleWord(korean: "용산역", braillePattern: "⠪⠕⠝⠎⠁⠝⠽⠕⠅"),
                    BrailleWord(korean: "김포공항", braillePattern: "⠅⠊⠍⠏⠕⠅⠕⠝⠓⠁⠝⠛"),
                    BrailleWord(korean: "청량리", braillePattern: "⠉⠗⠕⠝⠇⠑⠕⠝")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "출입문", braillePattern: "⠨⠥⠇⠊⠏⠍⠥⠝"),
                    BrailleWord(korean: "종착역", braillePattern: "⠨⠕⠝⠨⠁⠅⠽⠕⠅"),
                    BrailleWord(korean: "정류장", braillePattern: "⠚⠑⠕⠝⠛⠗⠽⠥⠚⠁⠝⠛"),
                    BrailleWord(korean: "운행시간", braillePattern: "⠥⠝⠓⠑⠝⠛⠎⠊⠁⠝"),
                    BrailleWord(korean: "노선도", braillePattern: "⠝⠕⠎⠕⠝⠙⠕"),
                    BrailleWord(korean: "차량번호", braillePattern: "⠉⠓⠁⠗⠽⠝⠃⠥⠝⠓⠕"),
                    BrailleWord(korean: "정차위치", braillePattern: "⠚⠓⠓⠉⠓⠁⠺⠊⠉⠓⠊"),
                    BrailleWord(korean: "승차권", braillePattern: "⠎⠝⠉⠓⠁⠅⠥⠝")
                ]
            }
        case .medicine:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "약", braillePattern: "⠽⠁⠅"),
                    BrailleWord(korean: "물약", braillePattern: "⠍⠥⠇⠽⠁⠅"),
                    BrailleWord(korean: "알약", braillePattern: "⠁⠇⠽⠁⠅"),
                    BrailleWord(korean: "연고", braillePattern: "⠽⠕⠝⠛⠕"),
                    BrailleWord(korean: "주사", braillePattern: "⠚⠥⠎⠁"),
                    BrailleWord(korean: "밴드", braillePattern: "⠃⠁⠝⠙"),
                    BrailleWord(korean: "파스", braillePattern: "⠏⠁⠎⠕"),
                    BrailleWord(korean: "기침약", braillePattern: "⠛⠊⠉⠓⠊⠍⠽⠁⠅")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "감기약", braillePattern: "⠛⠁⠍⠛⠊⠽⠁⠅"),
                    BrailleWord(korean: "소화제", braillePattern: "⠎⠕⠓⠗⠁⠚⠑"),
                    BrailleWord(korean: "해열제", braillePattern: "⠓⠁⠊⠽⠕⠇⠚⠑"),
                    BrailleWord(korean: "진통제", braillePattern: "⠚⠊⠝⠞⠕⠝⠛⠚⠑"),
                    BrailleWord(korean: "항생제", braillePattern: "⠓⠁⠝⠛⠎⠑⠝⠛⠚⠑"),
                    BrailleWord(korean: "비타민", braillePattern: "⠃⠊⠞⠁⠍⠊⠝"),
                    BrailleWord(korean: "영양제", braillePattern: "⠽⠕⠝⠛⠽⠁⠝⠛⠚⠑"),
                    BrailleWord(korean: "소독약", braillePattern: "⠎⠕⠙⠕⠅⠽⠁⠅")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "복약안내", braillePattern: "⠃⠕⠅⠽⠁⠅⠁⠝⠐⠑"),
                    BrailleWord(korean: "주의사항", braillePattern: "⠉⠥⠊⠎⠁⠓⠁⠝⠛"),
                    BrailleWord(korean: "의사소견", braillePattern: "⠥⠊⠎⠁⠎⠕⠛⠧⠑⠝"),
                    BrailleWord(korean: "처방전", braillePattern: "⠉⠓⠓⠃⠁⠝⠚⠕⠝"),
                    BrailleWord(korean: "복용시간", braillePattern: "⠃⠕⠅⠽⠕⠝⠎⠊⠛⠁⠝"),
                    BrailleWord(korean: "금기사항", braillePattern: "⠛⠥⠍⠛⠊⠎⠁⠓⠁⠝⠛"),
                    BrailleWord(korean: "약물반응", braillePattern: "⠽⠁⠅⠍⠥⠇⠃⠁⠝⠳"),
                    BrailleWord(korean: "장기복용", braillePattern: "⠚⠁⠝⠛⠊⠃⠕⠅⠽⠕⠝")
                ]
            }
        case .electronics:
            switch level {
            case .easy:
                return [
                    BrailleWord(korean: "전원", braillePattern: "⠨⠕⠝⠺⠕⠝"),
                    BrailleWord(korean: "볼륨", braillePattern: "⠃⠕⠇⠇⠥⠍"),
                    BrailleWord(korean: "전원", braillePattern: "⠨⠕⠝⠺⠕⠝"),
                    BrailleWord(korean: "볼륨", braillePattern: "⠃⠕⠇⠇⠥⠍"),
                    BrailleWord(korean: "충전", braillePattern: "⠉⠓⠕⠝⠨⠕⠝"),
                    BrailleWord(korean: "화면", braillePattern: "⠓⠗⠁⠍⠧⠕⠝"),
                    BrailleWord(korean: "버튼", braillePattern: "⠃⠥⠞⠞⠝"),
                    BrailleWord(korean: "리모컨", braillePattern: "⠗⠊⠍⠕⠅⠕⠝"),
                    BrailleWord(korean: "소리", braillePattern: "⠎⠕⠗⠊"),
                    BrailleWord(korean: "밝기", braillePattern: "⠃⠁⠇⠅⠊")
                ]
            case .normal:
                return [
                    BrailleWord(korean: "설정", braillePattern: "⠎⠕⠇⠨⠕⠝"),
                    BrailleWord(korean: "메뉴", braillePattern: "⠍⠑⠝⠥"),
                    BrailleWord(korean: "입력", braillePattern: "⠊⠇⠇⠽⠕⠅"),
                    BrailleWord(korean: "절전모드", braillePattern: "⠨⠕⠝⠚⠕⠇⠍⠕⠙⠑"),
                    BrailleWord(korean: "진동", braillePattern: "⠨⠊⠝⠙⠕⠝⠛"),
                    BrailleWord(korean: "음소거", braillePattern: "⠕⠍⠎⠕⠛⠕"),
                    BrailleWord(korean: "배경화면", braillePattern: "⠃⠁⠊⠛⠕⠝⠓⠗⠁⠍⠧⠕⠝"),
                    BrailleWord(korean: "데이터", braillePattern: "⠙⠑⠊⠞⠕⠗⠁")
                ]
            case .hard:
                return [
                    BrailleWord(korean: "무선연결", braillePattern: "⠍⠥⠎⠕⠝⠽⠕⠝⠨⠥⠇"),
                    BrailleWord(korean: "블루투스", braillePattern: "⠃⠇⠥⠇⠥⠞⠕⠎"),
                    BrailleWord(korean: "소프트웨어", braillePattern: "⠎⠕⠏⠞⠕⠺⠑⠗"),
                    BrailleWord(korean: "운영체제", braillePattern: "⠥⠝⠽⠕⠝⠉⠓⠑⠚⠑"),
                    BrailleWord(korean: "업데이트", braillePattern: "⠥⠏⠙⠑⠊⠞⠑"),
                    BrailleWord(korean: "시스템복원", braillePattern: "⠎⠊⠎⠞⠑⠍⠃⠕⠅⠕⠝"),
                    BrailleWord(korean: "네트워크", braillePattern: "⠝⠑⠞⠺⠕⠗⠅"),
                    BrailleWord(korean: "비밀번호", braillePattern: "⠃⠊⠍⠊⠇⠕⠝⠓⠕")
                ]
            }
        }
    }
}

