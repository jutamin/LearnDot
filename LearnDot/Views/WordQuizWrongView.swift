//
//  WordQuizWrongView.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import SwiftUI

struct WordQuizWrongView: View {
    
    let correctAnswer: String
        let onNextQuestion: () -> Void
        let onFinishLearning: () -> Void
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack {
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
                        }
                }
                
                Spacer().frame(height: 100)
                
                VStack(spacing: 13){
                    Text("오답입니다 😭")
                        .font(.mainTextBold32)
                        .foregroundStyle(.white00)
                    Group {
                        Text("정답은 ").foregroundStyle(.white00)
                        + Text("물").foregroundStyle(.blue01)
                        + Text(" 입니다.").foregroundStyle(.white00)
                    }.font(.mainTextSemiBold20)
                    
                    Text("다음 문제는 맞춰봐요!")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                }
                
                Spacer().frame(height: 187)
                
                HStack(spacing: 17) {
                    Button(action: {
                        print("학습 종료")
                        onFinishLearning()
                    }, label: {
                        QuitButtonCard()
                    })
                    
                    Button(action: {
                        print("다음 문제")
                        onNextQuestion()
                    }, label: {
                        NextButtonCard()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    WordQuizWrongView()
}
