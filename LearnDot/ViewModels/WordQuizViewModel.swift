//
//  WordQuizViewModel.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import Foundation

@Observable
class WordQuizViewModel: ObservableObject {
    @Published var currentQuizIndex = 0
    @Published var navigationDestination: QuizNavigationDestination?
    @Published var quizData: [QuizData] = []
    @Published var isLoading = true
    
    private let level: DifficultyLevel
    private let category: WordCategory
    
    init(level: DifficultyLevel, category: WordCategory) {
        self.level = level
        self.category = category
    }
    
    var currentQuiz: QuizData {
        guard currentQuizIndex < quizData.count else {
            return QuizData(brailleText: "", correctAnswer: "", options: [])
        }
        return quizData[currentQuizIndex]
    }
    
    func loadQuizData() {
        isLoading = true
        // 실제로는 비동기로 데이터를 로드할 수 있음
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5초 대기 (로딩 시뮬레이션)
            quizData = generateSampleQuizData(for: level, category: category)
            isLoading = false
        }
    }
    
    func checkAnswer(selectedOption: String) {
        let correctAnswer = currentQuiz.correctAnswer
        if selectedOption == correctAnswer {
            navigationDestination = .correct(correctAnswer: correctAnswer)
        } else {
            navigationDestination = .incorrect(correctAnswer: correctAnswer)
        }
    }
    
    func moveToNextQuestion() {
        currentQuizIndex += 1
        if currentQuizIndex >= quizData.count {
            // 모든 문제를 풀었으면 처음부터 다시 시작하거나 새로운 퀴즈 생성
            currentQuizIndex = 0
            generateNewQuizData()
        }
        navigationDestination = nil
    }
    
    func navigateToHome() {
        navigationDestination = .home
    }
    
    func resetQuiz() {
        currentQuizIndex = 0
        navigationDestination = nil
    }
    
    private func generateNewQuizData() {
        quizData = generateSampleQuizData(for: level, category: category)
        // 필요하다면 문제 순서를 섞을 수 있음
        quizData.shuffle()
    }
    
    private func generateSampleQuizData(for level: DifficultyLevel, category: WordCategory) -> [QuizData] {
        switch category {
        case .food:
            switch level {
            case .easy:
                return [
                    QuizData(brailleText: "⠎⠓", correctAnswer: "사과", options: ["사과", "포도", "귤", "딸기"]),
                    QuizData(brailleText: "⠏⠕⠙⠕", correctAnswer: "포도", options: ["사과", "포도", "귤", "딸기"]),
                    QuizData(brailleText: "⠅⠥⠇", correctAnswer: "귤", options: ["사과", "포도", "귤", "딸기"]),
                    QuizData(brailleText: "⠙⠙⠁⠇⠛⠊", correctAnswer: "딸기", options: ["사과", "포도", "귤", "딸기"])
                ]
            case .normal:
                return [
                    QuizData(brailleText: "⠓⠓⠎⠊⠅", correctAnswer: "한식", options: ["한식", "중식", "일식", "양식"]),
                    QuizData(brailleText: "⠉⠥⠓⠎⠊⠅", correctAnswer: "중식", options: ["한식", "중식", "일식", "양식"]),
                    QuizData(brailleText: "⠊⠇⠎⠊⠅", correctAnswer: "일식", options: ["한식", "중식", "일식", "양식"])
                ]
            case .hard:
                return [
                    QuizData(brailleText: "⠁⠍⠑⠗⠊⠅⠁⠝⠕", correctAnswer: "아메리카노", options: ["아메리카노", "카페라떼", "에스프레소", "카푸치노"]),
                    QuizData(brailleText: "⠅⠁⠏⠑⠇⠁⠞⠞⠑", correctAnswer: "카페라떼", options: ["아메리카노", "카페라떼", "에스프레소", "카푸치노"])
                ]
            }
        case .restroom:
            switch level {
            case .easy:
                return [
                    QuizData(brailleText: "⠓⠓⠚⠁", correctAnswer: "남자", options: ["남자", "여자", "화장실", "유아용"]),
                    QuizData(brailleText: "⠽⠕⠚⠁", correctAnswer: "여자", options: ["남자", "여자", "화장실", "유아용"]),
                    QuizData(brailleText: "⠓⠺⠁⠚⠁⠓⠛⠎⠊⠇", correctAnswer: "화장실", options: ["남자", "여자", "화장실", "유아용"])
                ]
            case .normal:
                return [
                    QuizData(brailleText: "⠎⠑⠍⠑⠓⠙⠓⠑", correctAnswer: "세면대", options: ["세면대", "휴지통", "자동문", "비누"]),
                    QuizData(brailleText: "⠓⠥⠚⠊⠞⠥⠓⠛", correctAnswer: "휴지통", options: ["세면대", "휴지통", "자동문", "비누"])
                ]
            case .hard:
                return [
                    QuizData(brailleText: "⠚⠓⠓⠛⠓⠊⠓⠓⠕⠇⠇⠃⠓⠞", correctAnswer: "장애인 호출 버튼", options: ["장애인 호출 버튼", "잠금 장치", "비상벨", "손잡이"]),
                    QuizData(brailleText: "⠚⠁⠍⠛⠥⠍⠚⠁⠓⠉⠊", correctAnswer: "잠금 장치", options: ["장애인 호출 버튼", "잠금 장치", "비상벨", "손잡이"])
                ]
            }
        case .transport:
            switch level {
            case .easy:
                return [
                    QuizData(brailleText: "⠎⠓⠥⠇", correctAnswer: "서울", options: ["서울", "경기", "대전", "대구"]),
                    QuizData(brailleText: "⠅⠽⠓⠓⠛⠛⠊", correctAnswer: "경기", options: ["서울", "경기", "대전", "대구"]),
                    QuizData(brailleText: "⠙⠓⠑⠚⠓⠓", correctAnswer: "대전", options: ["서울", "경기", "대전", "대구"]),
                    QuizData(brailleText: "⠃⠥⠎⠓⠓", correctAnswer: "부산", options: ["서울", "경기", "대전", "부산"])
                ]
            case .normal:
                return [
                    QuizData(brailleText: "⠎⠓⠥⠇⠽⠓⠅", correctAnswer: "서울역", options: ["서울역", "공릉역", "강남역", "홍대입구역"]),
                    QuizData(brailleText: "⠅⠕⠓⠛⠇⠇⠽⠓⠅", correctAnswer: "공릉역", options: ["서울역", "공릉역", "강남역", "홍대입구역"])
                ]
            case .hard:
                return [
                    QuizData(brailleText: "⠉⠓⠇⠊⠍⠍⠥⠓", correctAnswer: "출입문", options: ["출입문", "종착역", "승강장안내", "하차"]),
                    QuizData(brailleText: "⠚⠕⠓⠛⠉⠓⠅⠽⠓⠅", correctAnswer: "종착역", options: ["출입문", "종착역", "승강장안내", "하차"])
                ]
            }
        case .medicine:
            switch level {
            case .easy:
                return [
                    QuizData(brailleText: "⠽⠁⠅", correctAnswer: "약", options: ["약", "감기약", "두통약", "소화제"]),
                    QuizData(brailleText: "⠅⠓⠍⠛⠊⠽⠁⠅", correctAnswer: "감기약", options: ["약", "감기약", "두통약", "소화제"]),
                    QuizData(brailleText: "⠙⠥⠞⠥⠓⠛⠽⠁⠅", correctAnswer: "두통약", options: ["약", "감기약", "두통약", "소화제"])
                ]
            case .normal:
                return [
                    QuizData(brailleText: "⠎⠊⠅⠓⠕⠃⠕⠅⠽⠕⠓⠛", correctAnswer: "식후복용", options: ["식후복용", "하루2번", "공복복용", "취침전"]),
                    QuizData(brailleText: "⠓⠁⠇⠥⠊⠃⠁⠓", correctAnswer: "하루2번", options: ["식후복용", "하루2번", "공복복용", "취침전"])
                ]
            case .hard:
                return [
                    QuizData(brailleText: "⠃⠕⠅⠽⠁⠅⠁⠓⠓⠁⠊", correctAnswer: "복약안내", options: ["복약안내", "사용설명서", "약사상담", "부작용"]),
                    QuizData(brailleText: "⠎⠁⠽⠕⠓⠛⠎⠑⠇⠍⠽⠓⠓⠛⠎⠓", correctAnswer: "사용설명서", options: ["복약안내", "사용설명서", "약사상담", "부작용"])
                ]
            }
        case .electronics:
            switch level {
            case .easy:
                return [
                    QuizData(brailleText: "⠚⠓⠓⠛⠺⠓⠓", correctAnswer: "전원", options: ["전원", "볼륨", "재생", "정지"]),
                    QuizData(brailleText: "⠃⠕⠇⠇⠽⠥⠍", correctAnswer: "볼륨", options: ["전원", "볼륨", "재생", "정지"]),
                    QuizData(brailleText: "⠚⠓⠑⠎⠁⠓⠛", correctAnswer: "재생", options: ["전원", "볼륨", "재생", "정지"])
                ]
            case .normal:
                return [
                    QuizData(brailleText: "⠎⠑⠞⠞⠊⠓⠛", correctAnswer: "설정", options: ["설정", "메뉴", "저장", "취소"]),
                    QuizData(brailleText: "⠍⠑⠝⠥", correctAnswer: "메뉴", options: ["설정", "메뉴", "저장", "취소"])
                ]
            case .hard:
                return [
                    QuizData(brailleText: "⠍⠥⠎⠊⠇⠽⠓⠓⠕⠇", correctAnswer: "무선연결", options: ["무선연결", "접근성", "초기화설정", "블루투스"]),
                    QuizData(brailleText: "⠚⠕⠅⠛⠑⠓⠎⠓⠓⠛", correctAnswer: "접근성", options: ["무선연결", "접근성", "초기화설정", "블루투스"])
                ]
            }
        }
    }
}
