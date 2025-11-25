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
                Spacer()
                
                Text("퀴즈를 풀고,\n다시 보고 싶은 문제는\n저장할 수 있어요.")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("헷갈리는 점형은 저장해두고\n")
                        .foregroundStyle(.white00)
                    + Text("저장한 학습")
                        .foregroundStyle(.blue00)
                    + Text("에서 반복해서 익혀보세요.")
                        .foregroundStyle(.white00)
                    
                    Text("홈 화면에서 세 손가락으로\n")
                        .foregroundStyle(.white00)
                    + Text("왼쪽")
                        .foregroundStyle(.blue00)
                    + Text("으로 쓸어넘기면\n")
                        .foregroundStyle(.white00)
                    + Text("저장한 학습")
                        .foregroundStyle(.blue00)
                    + Text("으로 바로 이동해요.")
                        .foregroundStyle(.white00)
                }
                .font(.mainTextSemiBold18)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.manual4)
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

