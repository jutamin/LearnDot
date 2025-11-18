//
//  AbbreviationUnitView.swift
//  LearnDot
//
//  Created by juyeun on 11/18/25.
//

import SwiftUI

struct AbbreviationUnitView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    // MARK: - UI Setting
    var body: some View {
        ZStack {
            Color.black00
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    Text("약자, 약어 퀴즈")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                        .accessibilityLabel("약자, 약어 중에 학습할 단계를 골라주세요")
                    
                    Spacer()
                }
                .padding(.horizontal, 27)
                
                VStack(spacing: 16) {
                    SelectCard(
                        title: "약자",
                        description: "음절, 받침을 점형 한 칸으로 나타내는 점자 표기"
                    ) {
                        //coordinator.push(AppDestination.abbreviationQuiz(.contraction))
                    }
                    
                    SelectCard(
                        title: "약어",
                        description: "특정한 단어를 줄여 나타내는 점자 표기"
                    ) {
                        //coordinator.push(AppDestination.abbreviationQuiz(.abbreviations))
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
    AbbreviationUnitView()
        .environment(NavigationCoordinator())
}
