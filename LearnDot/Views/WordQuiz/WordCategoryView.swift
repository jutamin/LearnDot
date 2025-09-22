//
//  WordCategoryView.swift
//  LearnDot
//
//  Created by 신혜연 on 5/26/25.
//

import SwiftUI

struct WordCategoryView: View {
    let level: DifficultyLevel
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    Text("카테고리")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                        .accessibilityLabel("5개의 카테고리 중 하나를 골라주세요")
                    
                    Spacer()
                }
                .padding(.horizontal, 27)
                
                VStack(spacing: 16) {
                    ForEach(WordCategory.allCases) { category in
                        SelectCard(
                            title: category.rawValue,
                            description: category.description(for: level)
                        ) {
                            coordinator.push(AppDestination.wordQuiz(level, category))
                        }
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    WordCategoryView(level: .easy)
        .environment(NavigationCoordinator())
}
