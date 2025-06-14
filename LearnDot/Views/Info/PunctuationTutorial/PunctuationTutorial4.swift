//
//  PunctuationTutorial4.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct PunctuationTutorial4: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer().frame(height: 70)
                
                Text("문장부호 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundStyle(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityHidden(true)
                
                Spacer().frame(height: 27)
                
                Group {
                    
                    Text("4. 만약 점자 찍기를 처음부터 다시하려면\n     ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("’다시쓰기' 버튼")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.\n     답안을 제출하려면 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("’쓰기완료' 버튼")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                
                HStack(spacing: 17) {
                    Button{} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("다시쓰기")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.black00)
                            }
                    }
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("쓰기완료")
                                    .font(.mainTextBold24)
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
                        coordinator.push(AppDestination.punctuationTutorial5)
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
    PunctuationTutorial4()
        .environment(NavigationCoordinator())
}
