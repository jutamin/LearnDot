//
//  WordTutorial5.swift
//  LearnDot
//
//  Created by 원주연 on 6/12/25.
//

import SwiftUI
import KorToBraille

struct WordTutorial5: View {
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
                    
                    Text("5. 정답을 맞혔을 경우, 축하메시지와\n    정답 점형을 다시 들어볼 수 있어요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                Group {
                    Text("정답입니다!🎉")
                        .font(.mainTextBold32)
                        .foregroundStyle(.white00)
                    Spacer().frame(height: 8)
                    Text("다음 문제에도 도전해볼까요?")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                        .accessibilityHidden(true)
                    Spacer().frame(height: 52)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(KorToBraille.korTranslate("물"))
                                    .font(.mainTextExtraBold70)
                                    .foregroundStyle(.white00)
                                    .padding(.leading, 55)
                            }
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 40, height: 27, alignment: .topLeading)
                            .overlay {
                                Text("정답")
                                    .font(.mainTextSemiBold12)
                            }
                            .padding(.top, -70)
                            .padding(.leading, -106)
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
                        coordinator.push(AppDestination.wordTutorial6)
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
    WordTutorial5()
        .environment(NavigationCoordinator())
}
