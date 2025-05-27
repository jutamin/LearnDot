//
//  WordQuizView.swift
//  LearnDot
//
//  Created by 원주연 on 5/20/25.
//

import SwiftUI

// MARK: - Quiz Result Enum
enum QuizNavigationDestination: Identifiable {
    case correct(correctAnswer: String)
    case incorrect(correctAnswer: String)
    case home
    
    var id: String {
        switch self {
        case .correct: return "correct"
        case .incorrect: return "incorrect"
        case .home: return "home"
        }
    }
}

struct WordQuizView: View {
    
    let level: DifficultyLevel
    let category: WordCategory
    
    @StateObject private var viewModel: WordQuizViewModel
    
    init(level: DifficultyLevel, category: WordCategory) {
        self.level = level
        self.category = category
        self._viewModel = StateObject(wrappedValue: WordQuizViewModel(level: level, category: category))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black00
                    .ignoresSafeArea()
                
                VStack(spacing: 52) {
        
                    VStack(spacing: 16) {
                        Text("어떤 글자일까요?")
                            .font(.mainTextBold24)
                            .foregroundStyle(.blue00)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay {
                                Image("wordQuizDot")
                                Text(viewModel.currentQuiz.correctAnswer)
                            }
                    }
                    
                    
                    VStack(spacing: 16) {
                        ForEach(viewModel.currentQuiz.options, id: \.self) { option in
                            Button {
                                viewModel.checkAnswer(selectedOption: option)
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue00)
                                    .frame(width: 280, height: 90)
                                    .overlay{
                                        Text(option)
                                            .font(.mainTextSemiBold32)
                                            .foregroundStyle(.white00)
                                    }
                            }
                        }
                    }
                }
            }
//            .ignoresSafeArea()
            .onAppear {
                if viewModel.quizData.isEmpty {
                    viewModel.loadQuizData()
                }
            }
        }
        .navigationDestination(item: $viewModel.navigationDestination) { destination in
            switch destination {
            case .correct(let correctAnswer):
                WordQuizCorrectView(
                    correctAnswer: correctAnswer,
                    onNextQuestion: viewModel.moveToNextQuestion,
                    onFinishLearning: viewModel.navigateToHome
                )
            case .incorrect(let correctAnswer):
                WordQuizWrongView(
                    correctAnswer: correctAnswer,
                    onNextQuestion: viewModel.moveToNextQuestion,
                    onFinishLearning: viewModel.navigateToHome
                )
            case .home:
                HomeView()
            }
        }
    }
}

#Preview {
    WordQuizView()
}
