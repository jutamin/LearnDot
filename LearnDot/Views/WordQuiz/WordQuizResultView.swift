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
                Spacer().frame(height: 137)
                
                if isCorrect {
                    VStack(spacing: 13){
                        Text("정답입니다!🎉")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                        
                        Text("다음 문제에도 도전해볼까요?")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                    }
                } else {
                    VStack(spacing: 8){
                        Text("오답입니다 😭")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                        Group {
                            Text("정답은 ").foregroundStyle(.white00)
                            + Text(correctAnswer).foregroundStyle(.blue01)
                            + Text(" 입니다.").foregroundStyle(.white00)
                        }.font(.mainTextSemiBold20)
                        
                        Text("다음 문제는 맞춰봐요!")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                    }
                }
                
                Spacer()
                
                // 정답 점자
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
                            Text(braillePattern)
                                .font(.mainTextExtraBold36)
                                .padding(.leading, 30)
                        }
                    if !isCorrect {
                        Spacer().frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay {
                                Text(myAnswerBraillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                            }
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
                            Text(braillePattern)
                                .font(.mainTextExtraBold36)
                                .padding(.leading, 30)
                        }
                    if !isCorrect {
                        Spacer().frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 345, height: 112)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay {
                                Text(myAnswerBraillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                            }
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
                            Text(braillePattern)
                                .font(.mainTextExtraBold36)
                                .padding(.leading, 30)
                        }
                    if !isCorrect {
                        Spacer().frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 345, height: 150)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay {
                                Text(braillePattern)
                                    .font(.mainTextExtraBold36)
                                    .padding(.leading, 30)
                            }
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
