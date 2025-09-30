//
//  BasicQuizView.swift
//  LearnDot
//
//  Created by juyeun on 9/22/25.
//

import SwiftUI
import KorToBraille

struct BasicQuizView: View {
    
    let unit: BasicUnit
    @Environment(NavigationCoordinator.self) private var coordinator
    @State private var viewModel: BasicQuizViewModel
    
    init(unit: BasicUnit) {
        self.unit = unit
        self._viewModel = State(initialValue: BasicQuizViewModel(unit: unit))
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
                        
                        switch unit {
                        case .choseong:
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
                        case .jungseong:
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
                                    //                                        .padding(.leading, 20)
                                }
                        case .jongseong:
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
                                
                                let myAnswerBraillePattern: String
                                switch unit {
                                case .choseong:
                                    myAnswerBraillePattern = kor_cho[option] ?? ""
                                case .jungseong:
                                    myAnswerBraillePattern = kor_jung[option] ?? ""
                                case .jongseong:
                                    myAnswerBraillePattern = kor_jong[option] ?? ""
                                }
                                
                                coordinator.push(AppDestination.basicReult(isCorrect, unit, correctAnswer, braillePattern, myAnswerBraillePattern))
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
