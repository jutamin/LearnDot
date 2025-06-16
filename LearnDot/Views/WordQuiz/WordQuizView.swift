//
//  WordQuizView.swift
//  LearnDot
//
//  Created by 원주연 on 5/20/25.
//

import SwiftUI
import KorToBraille

struct WordQuizView: View {
    
    let level: DifficultyLevel
    let category: WordCategory
    @Environment(NavigationCoordinator.self) private var coordinator
    @State private var viewModel: WordQuizViewModel
    
    init(level: DifficultyLevel, category: WordCategory) {
        self.level = level
        self.category = category
        self._viewModel = State(initialValue: WordQuizViewModel(level: level, category: category))
    }
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("문제를 생성 중 ...")
                    .foregroundStyle(.white)
            } else if let quiz = viewModel.currentQuiz {
                VStack(spacing: 0) {
                    
                    // 점자 표시
                    VStack(spacing: 16) {
                        Text("어떤 글자일까요?")
                            .font(.mainTextBold24)
                            .foregroundStyle(.blue00)
                            .accessibilityLabel("주어지는 점형을 듣고, 4개의 보기 중 점자에 해당하는 단어를 골라주세요.")
                        
                        switch level {
                        case .easy:
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray06)
                                .frame(width: 240, height: 112)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .overlay {
                                    Text(quiz.brailleText.trimmingCharacters(in: ["⠀"]))
                                        .font(.mainTextExtraBold50)
//                                        .padding(.leading, 0)
                                }
                        case .normal:
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray06)
                                .frame(width: 345, height: 112)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .overlay {
                                    Text(quiz.brailleText.trimmingCharacters(in: ["⠀"]))
                                        .font(.mainTextExtraBold50)
//                                        .padding(.leading, 20)
                                }
                        case .hard:
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray06)
                                .frame(width: 345, height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .overlay {
                                    Text(quiz.brailleText.trimmingCharacters(in: ["⠀"]))
                                        .font(.mainTextExtraBold50)
//                                        .padding(.leading, 20)
                                        .lineLimit(nil)
                                }
                        }
                    }
                    .accessibilityElement(children: .combine)
                    
                    Spacer().frame(height: 52)
                    
                    // 선택지 버튼들
                    VStack(spacing: 16) {
                        ForEach(quiz.options, id: \.self) { option in
                            Button {
                                let isCorrect = viewModel.checkAnswer(option)
                                let correctAnswer = quiz.correctAnswer
                                let braillePattern = quiz.brailleText
                                let myAnswerBraillePattern = KorToBraille.korTranslate(option)
                                coordinator.push(AppDestination.result(isCorrect, level, category, correctAnswer, braillePattern, myAnswerBraillePattern))
                                /// test
                                print("문제 점형")
                                print(quiz.brailleText)
                                print("문제 점형 공백제거")
                                print(quiz.brailleText.trimmingCharacters(in: ["⠀"]))
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
                    
                    Spacer().frame(height: 80)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
