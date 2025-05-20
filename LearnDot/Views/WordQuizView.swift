//
//  WordQuizView.swift
//  LearnDot
//
//  Created by 원주연 on 5/20/25.
//

import SwiftUI

struct WordQuizView: View {
    var body: some View {
        ZStack {
            Color.black00
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
                        }
                }
                
                
                VStack(spacing: 16) {
                    Button(action: {
                        print("밥")
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 280, height: 90)
                            .overlay{
                                Text("밥")
                                    .font(.mainTextSemiBold32)
                                    .foregroundStyle(.white00)
                            }
                    })
                    
                    Button(action: {
                        print("물")
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 280, height: 90)
                            .overlay{
                                Text("물")
                                    .font(.mainTextSemiBold32)
                                    .foregroundStyle(.white00)
                            }
                    })
                    
                    Button(action: {
                        print("쌀")
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 280, height: 90)
                            .overlay{
                                Text("쌀")
                                    .font(.mainTextSemiBold32)
                                    .foregroundStyle(.white00)
                            }
                    })
                    
                    Button(action: {
                        print("죽")
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 280, height: 90)
                            .overlay{
                                Text("죽")
                                    .font(.mainTextSemiBold32)
                                    .foregroundStyle(.white00)
                            }
                    })
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WordQuizView()
}
