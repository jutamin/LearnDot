//
//  BasicUnitView.swift
//  LearnDot
//
//  Created by juyeun on 9/22/25.
//

import SwiftUI

struct BasicUnitView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    // MARK: - UI Setting
    var body: some View {
        ZStack {
            Color.black00
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    Text("자모 단계")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                        .accessibilityLabel("초성, 중성, 종성 중에 학습할 단계를 골라주세요")
                    
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
                }
                .padding(.top, 30)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BasicUnitView()
        .environment(NavigationCoordinator())
}
