//
//  NumberQuizView.swift
//  LearnDot
//
//  Created by 신혜연 on 11/17/25.
//

import SwiftUI
import KorToBraille

struct NumberQuizView: View {
    
    @Environment(NavigationCoordinator.self) private var coordinator
    @State private var viewModel = NumberQuizViewModel()
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("문제를 생성 중 ...")
                    .foregroundStyle(.white)
            } else if let quiz = viewModel.currentQuiz {
                VStack(spacing: 0) {
                        
                    VStack(spacing: 16) {
                        Text("어떤 숫자일까요?")
                            .font(.mainTextBold24)
                            .foregroundStyle(.blue00)
                            .accessibilityLabel("주어지는 점형을 듣고, 4개의 보기 중 점자에 해당하는 숫자를 골라주세요.")
                            
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
                                    .accessibilityLabel(quiz.brailleText.toBrailleDotSpeech())
                                    .lineLimit(nil)
                            }
                    }
                    .accessibilityElement(children: .combine)
                        
                    Spacer().frame(height: 52)
                        
                    VStack(spacing: 16) {
                        ForEach(quiz.options, id: \.self) { option in
                            Button {
                                let isCorrect = viewModel.checkAnswer(option)
                                let correctAnswer = quiz.correctAnswer
                                let braillePattern = quiz.brailleText
                                
                                let myAnswerBraillePattern = KorToBraille.korTranslate(option)
                                
                                coordinator.push(AppDestination.numberResult(
                                    isCorrect,
                                    correctAnswer,
                                    braillePattern,
                                    myAnswerBraillePattern
                                ))
                                
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.popToRoot()
                } label: {
                    Text("홈으로")
                        .foregroundColor(.white00)
                        .font(.mainTextSemiBold18)
                }
            }
        }
        .onAppear {
            viewModel.generateQuize()
        }
    }
}
