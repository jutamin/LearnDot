//
//  Manual2.swift
//  LearnDot
//
//  Created by 원주연 on 6/11/25.
//

import SwiftUI

struct Manual2: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text("문장부호는 직접 점을 찍어보도록 구성되어 있어요.")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    Text("1~6번 점을 선택해 입력하고,\n필요하면 ")
                        .foregroundStyle(.white00)
                    + Text("‘다음 점자’")
                        .foregroundStyle(.blue00)
                    + Text(" 또는 ")
                        .foregroundStyle(.white00)
                    + Text("‘이전 점자’")
                        .foregroundStyle(.blue00)
                    + Text("로\n이동하며 수정할 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("문장부호를 실제처럼 조작하며\n익히는 학습이에요.")
                        .foregroundStyle(.white00)
                }
                .font(.mainTextSemiBold18)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.manual3)
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

