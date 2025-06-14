//
//  PunctuationTutorial5.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct PunctuationTutorial5: View {
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
                    Text("5. 학습을 그만하고 싶다면,\n     ")
                        .foregroundStyle(.white00)
                    + Text("'학습종료' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.\n     계속해서 다음 문제를 풀어보고 싶다면,\n     ")
                        .foregroundStyle(.white00)
                    + Text("'다음문제' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.")
                        .foregroundStyle(.white00)
                }
                .font(.mainTextSemiBold16)
                
                Spacer()
                
                HStack(spacing: 17) {
                    Button {
                        
                    } label: {
                        QuitButtonCard()
                    }
                    
                    Button{
                        
                    } label: {
                        NextButtonCard()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Text("문장부호 점형 학습 튜토리얼이 끝났습니다.\n'종료' 버튼을 누르면 도움말 화면으로 이동합니다.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                    .frame(alignment: .leading)
                
                Spacer().frame(height: 24)
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.popToRoot()
                        coordinator.push(AppDestination.info)
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("종료")
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
    PunctuationTutorial5()
        .environment(NavigationCoordinator())
}
