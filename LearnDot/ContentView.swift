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
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
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
                    case .basicUnit:
                        BasicUnitView()
                    case .basicQuiz(let unit):
                        BasicQuizView(unit: unit)
                    case .basicReult(let isCorrect, let unit, let correctAnswer, let braillePattern, let myAnswerBraillePattern):
                        BasicQuizResultView(isCorrect: isCorrect, unit: unit, correctAnswer: correctAnswer, braillePattern: braillePattern, myAnswerBraillePattern: myAnswerBraillePattern)
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
                    case .punctuationTutorial0:
                        PucntuationQuizTutorialView()
                    case .punctuationTutorial1:
                        PunctuationTutorial1()
                    case .punctuationTutorial2:
                        PunctuationTutorial2()
                    case .punctuationTutorial3:
                        PunctuationTutorial3()
                    case .punctuationTutorial4:
                        PunctuationTutorial4()
                    case .punctuationTutorial5:
                        PunctuationTutorial5()
                    case .savedLearningView:
                        SavedLearningView()
                    case .savedLearningWordView:
                        SavedLearningWordView()
                    case .savedLearningWordDetailView(let itemID):
                        SavedLearningWordDetailView(itemID: itemID)
                    }
                }
        }
        .environment(coordinator)
        .fullScreenCover(isPresented: $isFirstLaunching) {
            OnboardingView()
        }
        
    }
}

#Preview {
    ContentView()
}
