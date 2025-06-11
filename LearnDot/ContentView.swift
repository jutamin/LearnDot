//
//  ContentView.swift
//  LearnDot
//
//  Created by 원주연 on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var coordinator = NavigationCoordinator()
    @StateObject private var punctuationViewModel = PunctuationQuizViewModel()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView()
                .navigationDestination(for: AppDestination.self) { destination in
                    switch destination {
                    case .wordLevel:
                        WordLevelView()
                    case .wordCategory(let level):
                        WordCategoryView(level: level)
                    case .wordQuiz(let level, let category):
                        WordQuizView(level: level, category: category)
                    case .result(let isCorrect, let level, let category, let correctAnswer, let braillePattern, let myAnswerBraillePattern):
                        WordQuizResultView(isCorrect: isCorrect, level: level, category: category, correctAnswer: correctAnswer, braillePattern: braillePattern, myAnswerBraillePattern: myAnswerBraillePattern)
                    case .PunctuationQuiz:
                        PunctuationQuizView()
                            .environmentObject(punctuationViewModel)
                    case .PunctuationResult(let isCorrect):
                        PunctuationQuizResultView(isCorrect: isCorrect)
                            .environmentObject(punctuationViewModel)
                    }
                }
        }
        .environment(coordinator)
    }
}

#Preview {
    ContentView()
}
