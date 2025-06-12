//
//  WordTutorial1.swift
//  LearnDot
//
//  Created by 원주연 on 6/12/25.
//

import SwiftUI

struct WordTutorial1: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer().frame(height: 70)
                
                Text("난이도별 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundStyle(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityHidden(true)
                
                Spacer().frame(height: 27)
                
                Group {
                    
                    Text("1. 난이도는 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("쉬움/보통/어려움 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                        .accessibilityLabel("쉬움, 보통, 어려움")
                    + Text("3단계로 나누어져요.\n    학습 난이도를 선택해주세요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 276, height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("쉬움")
                                        .font(.mainTextSemiBold18)
                                        .foregroundStyle(.blue00)
                                    
                                    Text("1-2개의 점자 셀로 구성된 단어")
                                        .font(.mainTextSemiBold13)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 276, height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("보통")
                                        .font(.mainTextSemiBold18)
                                        .foregroundStyle(.blue00)
                                    
                                    Text("3~4셀 이상 또는 합성어")
                                        .font(.mainTextSemiBold13)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 276, height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("어려움")
                                        .font(.mainTextSemiBold18)
                                        .foregroundStyle(.blue00)
                                    
                                    Text("외래어, 긴 단어, 추상어")
                                        .font(.mainTextSemiBold13)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Text("'다음' 버튼을 눌러주세요.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                    .frame(alignment: .leading)
                
                Spacer().frame(height: 24)
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.wordTutorial2)
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("다음")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.white)
                            }
                    }
                }
                
                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    WordTutorial1()
        .environment(NavigationCoordinator())
}
