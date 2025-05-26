//
//  WordLevelView.swift
//  LearnDot
//
//  Created by 신혜연 on 5/20/25.
//

import SwiftUI

struct WordLevelView: View {
    
    // MARK: - Properties
    @State private var selectedLevel: DifficultyLevel?
    
    // MARK: - UI Setting
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black00
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 82)
                    
                    HStack {
                        Text("난이도")
                            .font(.mainTextExtraBold36)
                            .foregroundStyle(.white00)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 27)
                    
                    VStack(spacing: 16) {
                        SelectCard(
                            title: "쉬움",
                            description: "1-2개의 점자 셀로 구성된 단어"
                        ) {
                            selectedLevel = .easy
                        }
                        
                        SelectCard(
                            title: "보통",
                            description: "3-4셀 이상 또는 합성어"
                        ) {
                            selectedLevel = .normal
                        }
                        
                        SelectCard(
                            title: "어려움",
                            description: "외래어, 긴 단어, 추상어"
                        ) {
                            selectedLevel = .hard
                        }
                    }
                    .padding(.top, 30)
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(item: $selectedLevel) { level in
            WordCategoryView(level: level)
        }
    }
}

#Preview {
    WordLevelView()
}
