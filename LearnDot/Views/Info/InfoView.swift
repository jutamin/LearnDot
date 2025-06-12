//
//  InfoView.swift
//  LearnDot
//
//  Created by 원주연 on 6/11/25.
//

import SwiftUI

struct InfoView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack {
                List {
                    Button {
                        coordinator.push(AppDestination.manual0)
                    } label: {
                        Text("사용법 안내")
                            .foregroundColor(.white00)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.white00)
                            .accessibilityHidden(true)
                    }
                    .listRowBackground(Color.gray06) // 배경 색깔 조절 가능
                    
                    Button {
                        coordinator.push(AppDestination.wordTutorial0)
                    } label: {
                        Text("난이도별 점형 학습 튜토리얼")
                            .foregroundColor(.white00) // 리스트 기본 텍스트 색상
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.white00)
                            .accessibilityHidden(true)
                    }
                    .listRowBackground(Color.gray06)
                    
                    Button {
                        coordinator.push(AppDestination.manual0)
                    } label: {
                        Text("문장부호 점형 학습 튜토리얼")
                            .foregroundColor(.white00) // 리스트 기본 텍스트 색상
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.white00)
                            .accessibilityHidden(true)
                    }
                    .listRowBackground(Color.gray06) // 배경 색깔 조절 가능
                }
                .listRowBackground(Color.gray06) // 배경 색깔 조절 가능
                .buttonStyle(PlainButtonStyle())
                .background(Color.clear)          // 리스트 전체 배경도 투명하게
                .scrollContentBackground(.hidden)
                
                Button {
                    coordinator.push(AppDestination.manual0)
                } label: {
                    Text("manual")
                }
            }
        }
    }
}

#Preview {
    InfoView()
        .environment(NavigationCoordinator())
}
