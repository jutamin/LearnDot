//
//  WordTutorial4.swift
//  LearnDot
//
//  Created by 원주연 on 6/12/25.
//

import SwiftUI

struct WordTutorial4: View {
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
                    
                    Text("4. 4개의 선택지 버튼 중 문제 점형과 일치하는\n    선택지를 하나 골라주세요.\n    다음과 같이 4개의 버튼이 제시됩니다.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                
                Spacer()
                
                Group {
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 195, height: 63)
                            .overlay{
                                Text("밥")
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 195, height: 63)
                            .overlay{
                                Text("물")
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 195, height: 63)
                            .overlay{
                                Text("쌀")
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 195, height: 63)
                            .overlay{
                                Text("죽")
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
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
                        coordinator.push(AppDestination.wordTutorial5)
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
    WordTutorial4()
        .environment(NavigationCoordinator())
}
