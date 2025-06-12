//
//  NavigationCoordinator.swift
//  LearnDot
//
//  Created by 원주연 on 5/30/25.
//

import SwiftUI

@Observable
class NavigationCoordinator {
    var path = NavigationPath()
    
    func push<T: Hashable>(_ destination: T) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

// MARK: - Navigation Destinations
enum AppDestination: Hashable {
    case wordLevel
    case wordCategory(DifficultyLevel)
    case wordQuiz(DifficultyLevel, WordCategory)
    case PunctuationQuiz
    case PunctuationResult(Bool) // isCorrect
    case result(Bool, DifficultyLevel, WordCategory, String, String, String) // isCorrect, level, category, correctAnswer, braillePattern, myAnswerBraillePattern
    case info
    case manual0
    case manual1
    case manual2
    case manual3
    case wordTutorial0
    case wordTutorial1
    case wordTutorial2
    case wordTutorial3
    case wordTutorial4
    case wordTutorial5
    case wordTutorial6
    case wordTutorial7
}
