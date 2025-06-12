//
//  ContentView.swift
//  LearnDot
//
//  Created by 원주연 on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var coordinator = NavigationCoordinator()
    @EnvironmentObject private var punctuationViewModel: PunctuationQuizViewModel
    
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
                    case .info:
                        InfoView()
                    case .manual0:
                        ManualView()
                    case .manual1:
                        Manual1()
                    case .manual2:
                        Manual2()
                    case .manual3:
                        Manual3()
                    case .wordTutorial0:
                        WordQuizTutorialView()
                    case .wordTutorial1:
                        WordTutorial1()
                    case .wordTutorial2:
                        WordTutorial2()
                    case .wordTutorial3:
                        WordTutorial3()
                    case .wordTutorial4:
                        WordTutorial4()
                    case .wordTutorial5:
                        WordTutorial5()
                    case .wordTutorial6:
                        WordTutorial6()
                    case .wordTutorial7:
                        WordTutorial7()
                    }
                }
        }
        .environment(coordinator)
    }
}

#Preview {
    ContentView()
}
