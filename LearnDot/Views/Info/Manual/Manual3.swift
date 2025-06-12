//
//  Manual3.swift
//  LearnDot
//
//  Created by 원주연 on 6/11/25.
//

import SwiftUI

struct Manual3: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 100)
                
                Text("문장부호 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("1. 문제로 문장부호가 주어져요.\n    주어진 문장부호의 ")
                        .foregroundStyle(.white00)
                    + Text("점형을 직접 찍어보세요.")
                        .foregroundStyle(.blue00)
                    
                    Text("2. 번호가 붙은 6개의 버튼이 준비되어 있어요.\n    한 번 누르면 해당 번호의 점자가 입력되고,\n    한 번 더 누르면 입력이 취소돼요.")
                        .foregroundStyle(.white00)
                    
                    Text("3. 만약 2개의 점자 셀이 필요하다면, ")
                        .foregroundStyle(.white00)
                    + Text("'다음점자'\n    버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러 다음 점자를 찍을 수 있어요.\n    첫 번째 점자의 수정이 필요하다면, ")
                        .foregroundStyle(.white00)
                    + Text("'이전 점자'\n    버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러 이전 점자를 수정할 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("4. 만약 점자 찍기를 처음부터 다시하려면,\n")
                        .foregroundStyle(.white00)
                    + Text("    '다시찍기' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.\n    답안을 제출하려면,")
                        .foregroundStyle(.white00)
                    + Text("'찍기완료' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.")
                        .foregroundStyle(.white00)
                    
                    
                }
                .font(.mainTextSemiBold16)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.pop()
                        coordinator.pop()
                        coordinator.pop()
                        coordinator.pop() // 다시 InfoView로 이동
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("설명 종료")
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
    Manual3()
}
