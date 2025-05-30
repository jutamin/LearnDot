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
                VStack(spacing: 16) {
                    Spacer()
                        .frame(height: 140)
                    
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
            .navigationTitle("카테고리 선택")
        }
    }
}

#Preview {
    WordCategoryView(level: .easy)
}
