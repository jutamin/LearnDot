//
//  SavedLearningView.swift
//  LearnDot
//
//  Created by 신혜연 on 10/21/25.
//

import SwiftUI

struct SavedLearningView: View {
    
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 96)
                
                HStack {
                    Text("저장한 학습")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                    
                    Spacer()
                }
                .padding(.horizontal, 27)
                
                VStack(spacing: 16) {
                    SelectLearning(
                        title: "기초단계 점형 학습"
                    ) {
                        coordinator.push(AppDestination.savedLearningWordView)
                    }
                    
                    SelectLearning(
                        title: "난이도별 점형 학습"
                    ) {
                        coordinator.push(AppDestination.savedLearningLevelView)
                    }
                    
                    SelectLearning(
                        title: "문장부호 점형 학습"
                    ) {
                        coordinator.push(AppDestination.savedLearningPunctuationView)
                    }
                    
                    SelectLearning(
                        title: "숫자 점형 학습"
                    ) {
                        coordinator.push(AppDestination.savedLearningNumberView)
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
    SavedLearningView()
}
