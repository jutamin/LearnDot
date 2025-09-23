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
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 100)
                
                Text("문장부호 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("1. 문제로 제시된 문장부호의 ")
                        .foregroundStyle(.white00)
                    + Text("점형을 직접 찍어보세요.")
                        .foregroundStyle(.blue00)
                    
                    Text("2. 1번부터 6번까지 버튼을 눌러 점을 입력할 수 있고,\n    다시 누르면 입력이 취소돼요.")
                        .foregroundStyle(.white00)
                    
                    Text("3. 2개의 점자 셀이 필요하다면 ")
                        .foregroundStyle(.white00)
                    + Text("'다음점자' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을,\n    이전 셀의 수정이 필요하다면 ")
                        .foregroundStyle(.white00)
                    + Text("'이전 점자' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을\n    사용하세요.")
                        .foregroundStyle(.white00)
                    
                    Text("4. 처음부터 다시하려면 ")
                        .foregroundStyle(.white00)
                    + Text("'다시찍기' 버튼을,\n")
                        .foregroundStyle(.blue00)
                    + Text("     답안을 제출하려면 ")
                        .foregroundStyle(.white00)
                    + Text("'찍기완료' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 누르세요.")
                        .foregroundStyle(.white00)
                }
                .font(.mainTextSemiBold16)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.popToRoot()
                        coordinator.push(AppDestination.info) // 다시 InfoView로 이동
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

