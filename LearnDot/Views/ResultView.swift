//
//  ResultView.swift
//  LearnDot
//
//  Created by 원주연 on 5/30/25.
//

import SwiftUI

struct ResultView: View {
    let isCorrect: Bool
    let level: DifficultyLevel
    let category: WordCategory
    let correctAnswer: String
    let braillePattern: String
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
                
                // 정답 점자
                Text(braillePattern)
                
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
    }
}
//
//#Preview {
//    ResultView()
//}
