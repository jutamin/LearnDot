//
//  BasicQuizResultView.swift
//  LearnDot
//
//  Created by juyeun on 9/22/25.
//

import SwiftUI

struct BasicQuizResultView: View {
    let isCorrect: Bool
    let unit: BasicUnit
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
                switch unit {
                case .choseong:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(braillePattern.trimmingCharacters(in: ["⠀"]))
                                    .font(.mainTextExtraBold50)
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
                                    Text(myAnswerBraillePattern.trimmingCharacters(in: ["⠀"]))
                                        .font(.mainTextExtraBold50)
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
                case .jungseong:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(braillePattern.trimmingCharacters(in: ["⠀"]))
                                    .font(.mainTextExtraBold50)
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
                                    Text(myAnswerBraillePattern.trimmingCharacters(in: ["⠀"]))
                                        .font(.mainTextExtraBold50)
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
                case .jongseong:
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(braillePattern.trimmingCharacters(in: ["⠀"]))
                                    .font(.mainTextExtraBold50)
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
                                    Text(myAnswerBraillePattern.trimmingCharacters(in: ["⠀"]))
                                        .font(.mainTextExtraBold50)
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
                        coordinator.push(AppDestination.basicQuiz(unit))
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
