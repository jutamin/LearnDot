//
//  WordQuizTutorialView.swift
//  LearnDot
//
//  Created by 원주연 on 6/11/25.
//

import SwiftUI

struct WordQuizTutorialView: View {
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Spacer().frame(height: 100)
                
                Group {
                    Text("난이도별 점형 학습 안내\n")
                        .font(.mainTextBold32)
                        .foregroundStyle(.white00)
                    + Text("\n난이도와 카테고리를 지정한 후, \n단어의 점형을 듣고 어떤 단어인지\n맞추는 게임이예요.\n")
                        .font(.mainTextBold24)
                        .foregroundStyle(.white00)
                        
                    + Text("\n한 손가락으로 화면을 왼쪽에서 오른쪽으로 빠르게 쓸어보세요.\n다음 안내로 넘어가요.")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                }
//                .accessibilityElement(children: .combine)
                
                Spacer().frame(height: 30)
                
                Text("‘버튼’은 빠르게 두 번 탭하면 선택돼요.\n이제 화면을 왼쪽에서 오른쪽으로 쓸어넘긴 다음,\n‘다음’ 버튼을 빠르게 두 번 탭하여 다음 안내로 넘어가주세요.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                    .lineSpacing(3)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.wordTutorial1)
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
    WordQuizTutorialView()
        .environment(NavigationCoordinator())
}
