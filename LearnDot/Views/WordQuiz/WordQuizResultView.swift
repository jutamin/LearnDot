//
//  WordQuizResultView.swift
//  LearnDot
//
//  Created by 원주연 on 5/30/25.
//

import SwiftUI

struct WordQuizResultView: View {
    let isCorrect: Bool
    let level: DifficultyLevel
    let category: WordCategory
    let correctAnswer: String
    let braillePattern: String
    let myAnswerBraillePattern: String
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                if isCorrect {
                    VStack(spacing: 13){
                        Text("정답입니다!🎉")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                            .accessibilityLabel("정답입니다")
                        
                        Text("다음 문제에도 도전해볼까요?")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                            .accessibilityHidden(true)
                    }
                    .accessibilityElement(children: .combine)
                } else {
                    VStack(spacing: 8){
                        Text("오답입니다 😭")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                            .accessibilityLabel("오답입니다")
                        
                        Group {
                            Text("정답은 ").foregroundStyle(.white00)
                            + Text(correctAnswer).foregroundStyle(.blue01)
                            + Text(" 입니다.").foregroundStyle(.white00)
                        }.font(.mainTextSemiBold20)
                        
                        Text("다음 문제는 맞춰봐요!")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                            .accessibilityHidden(true)
                    }
                    .accessibilityElement(children: .combine)
                }
                
                Spacer().frame(height: 52)
                
                // 정답 점자
                switch level {
                case .easy:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(braillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                                    .accessibilitySortPriority(0)
                            }
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 40, height: 27, alignment: .topLeading)
                            .overlay {
                                Text("정답")
                                    .font(.mainTextSemiBold12)
                                    .accessibilityLabel("정답 점형")
                                    .accessibilitySortPriority(1)
                            }
                            .padding(.top, -70)
                            .padding(.leading, -106)
                    }
                    .accessibilityElement(children: .combine)
                    if !isCorrect {
                        Spacer().frame(height: 22)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray06)
                                .frame(width: 240, height: 112)
                                .overlay {
                                    Text(myAnswerBraillePattern)
                                        .font(.mainTextExtraBold36)
                                        .padding(.leading, 30)
                                        .accessibilitySortPriority(0)
                                }
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.blue00)
                                .frame(width: 76, height: 27)
                                .overlay {
                                    Text("내가 고른 답")
                                        .font(.mainTextSemiBold12)
                                        .accessibilityLabel("내가 고른 답의 점형")
                                        .accessibilitySortPriority(1)
                                }
                                .padding(.top, -70)
                                .padding(.leading, -106)
                        }
                        .accessibilityElement(children: .combine)
                    }
                case .normal:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 345, height: 112)
                            .overlay {
                                Text(braillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                                    .accessibilitySortPriority(0)
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 40, height: 27)
                            .overlay {
                                Text("정답")
                                    .font(.mainTextSemiBold12)
                                    .accessibilityLabel("정답 점형")
                                    .accessibilitySortPriority(1)
                            }
                            .padding(.top, -70)
                            .padding(.leading, -159)
                    }
                    .accessibilityElement(children: .combine)
                    if !isCorrect {
                        Spacer().frame(height: 22)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray06)
                                .frame(width: 345, height: 112)
                                .overlay {
                                    Text(myAnswerBraillePattern)
                                        .font(.mainTextExtraBold36)
                                        .padding(.leading, 30)
                                        .accessibilitySortPriority(0)
                                }
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.blue00)
                                .frame(width: 76, height: 27)
                                .overlay {
                                    Text("내가 고른 답")
                                        .font(.mainTextSemiBold12)
                                        .accessibilityLabel("내가 고른 답의 점형")
                                        .accessibilitySortPriority(1)
                                }
                                .padding(.top, -70)
                                .padding(.leading, -159)
                        }
                        .accessibilityElement(children: .combine)
                    }
                case .hard:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 345, height: 150)
                            .overlay {
                                Text(braillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                                    .accessibilitySortPriority(0)
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 40, height: 27)
                            .overlay {
                                Text("정답")
                                    .font(.mainTextSemiBold12)
                                    .accessibilityLabel("정답 점형")
                                    .accessibilitySortPriority(1)
                            }
                            .padding(.top, -89)
                            .padding(.leading, -159)
                    }
                    .accessibilityElement(children: .combine)
                    if !isCorrect {
                        Spacer().frame(height: 22)
                        
                        ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 345, height: 150)
                            .overlay {
                                Text(myAnswerBraillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                                    .accessibilitySortPriority(0)
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 76, height: 27)
                            .overlay {
                                Text("내가 고른 답")
                                    .font(.mainTextSemiBold12)
                                    .accessibilityLabel("내가 고른 답의 점형")
                                    .accessibilitySortPriority(1)
                            }
                            .padding(.top, -89)
                            .padding(.leading, -159)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                
                Spacer()
                
                // 학습종료 or 다음문제
                HStack(spacing: 17) {
                    Button {
                        coordinator.popToRoot()
                    } label: {
                        QuitButtonCard()
                    }
                    
                    Button{
                        coordinator.push(AppDestination.wordQuiz(level, category))
                    } label: {
                        NextButtonCard()
                    }
                }
                
                Spacer().frame(height: 80)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
//
//#Preview {
//    WordQuizResultView()
//}
