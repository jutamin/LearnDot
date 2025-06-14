//
//  WordTutorial6.swift
//  LearnDot
//
//  Created by 원주연 on 6/12/25.
//

import SwiftUI
import KorToBraille

struct WordTutorial6: View {
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
                    
                    Text("6. 오답을 골랐을 경우, 안내 메시지와 정답,\n    내가 고른 답의 점형을 다시 들어볼 수 있어요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                Group {
                    VStack(spacing: 4){
                        Text("오답입니다 😭")
                            .font(.mainTextBold24)
                            .foregroundStyle(.white00)
                        Group {
                            Text("정답은 ").foregroundStyle(.white00)
                            + Text("물").foregroundStyle(.blue01)
                            + Text(" 입니다.").foregroundStyle(.white00)
                        }.font(.mainTextSemiBold16)
                        
                        Text("다음 문제는 맞춰봐요!")
                            .font(.mainTextSemiBold13)
                            .foregroundStyle(.gray02)
                    }
                    Spacer().frame(height: 30)
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
                    Spacer().frame(height: 22)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(KorToBraille.korTranslate("밥"))
                                    .font(.mainTextExtraBold70)
                                    .foregroundStyle(.white00)
                                    .padding(.leading, 55)
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 76, height: 27)
                            .overlay {
                                Text("내가 고른 답")
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
                        coordinator.push(AppDestination.wordTutorial7)
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
    WordTutorial6()
        .environment(NavigationCoordinator())
}
