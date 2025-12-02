//
//  ChartSelectView.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//

import SwiftUI

struct ChartSelectView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    // MARK: - UI Setting
    var body: some View {
        ZStack {
            Color.black00
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    Text("일람표 선택")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                        .accessibilityLabel("초성, 중성, 종성, 숫자, 약자, 약어 중 선택해주세요")
                    
                    Spacer()
                }
                .padding(.horizontal, 27)
                
                VStack(spacing: 16) {
                    SelectCard(
                        title: "초성",
                        description: "글자의 맨 앞 소리, 자음"
                    ) {
                        coordinator.push(AppDestination.basicQuiz(.choseong))
                    }
                    
                    SelectCard(
                        title: "중성",
                        description: "글자의 중심 소리, 모음"
                    ) {
                        coordinator.push(AppDestination.basicQuiz(.jungseong))
                    }
                    
                    SelectCard(
                        title: "종성",
                        description: "글자의 끝소리, 받침"
                    ) {
                        coordinator.push(AppDestination.basicQuiz(.jongseong))
                    }
                    
                    SelectCard(
                        title: "숫자",
                        description: "숫자를 나타내는 점자"
                    ) {
                        coordinator.push(AppDestination.basicQuiz(.jongseong))
                    }
                    
                    SelectCard(
                        title: "약자",
                        description: "한 글자를 줄여 나타내는 점자"
                    ) {
                        coordinator.push(AppDestination.basicQuiz(.jongseong))
                    }
                    
                    SelectCard(
                        title: "약어",
                        description: "여러 글자를 줄여 나타내는 점자"
                    ) {
                        coordinator.push(AppDestination.basicQuiz(.jongseong))
                    }
                }
                .padding(.top, 30)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ChartSelectView()
        .environment(NavigationCoordinator())
}
