//
//  HomeView.swift
//  LearnDot
//
//  Created by 신혜연 on 5/26/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @State private var isWordLevelActive = false
    
    // MARK: - UI Setting
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black00
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 82)
                    
                    HStack {
                        Text("점형 학습 게임")
                            .font(.mainTextExtraBold36)
                            .foregroundStyle(.white00)
                        
                        Spacer()
                        
                        Button {
                            // TODO: 설정 뷰로 이동
                        } label: {
                            Image(systemName: "gearshape")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 38, height: 42)
                                .foregroundStyle(.white00)
                        }
                    }
                    .padding(.horizontal, 27)
                    
                    VStack(spacing: 16) {
                        SelectCard(
                            title: "난이도별 점형 학습",
                            description: "단계별로 점형 맞추기"
                        ) {
                            isWordLevelActive = true
                        }
                        
                        SelectCard(
                            title: "문장부호 점형 학습",
                            description: "문장부호 퀴즈 맞추기"
                        ) {
                            
                        }
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isWordLevelActive) {
                WordLevelView()
            }
        }
    }
}

#Preview {
    HomeView()
}
