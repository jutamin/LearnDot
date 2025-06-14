//
//  WordTutorial3.swift
//  LearnDot
//
//  Created by 원주연 on 6/12/25.
//

import SwiftUI
import KorToBraille

struct WordTutorial3: View {
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
                    
                    Text("3. 한 단어에 대한 점형이 주어져요.\n    어떤 글자일까요? 라는 문구 다음에,\n    주어진 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("점형 번호를 음성으로 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                    
                    + Text("들을 수 있어요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                
                Text("어떤 글자일까요?")
                    .font(.mainTextBold24)
                    .foregroundStyle(.blue00)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray06)
                    .frame(width: 240, height: 112)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .overlay {
                        Text(KorToBraille.korTranslate("물"))
                            .font(.mainTextExtraBold70)
                            .foregroundStyle(.white00)
                            .padding(.leading, 55)
                            .frame(maxWidth: .infinity, alignment: .center)
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
                        coordinator.push(AppDestination.wordTutorial4)
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
    WordTutorial3()
        .environment(NavigationCoordinator())
}
