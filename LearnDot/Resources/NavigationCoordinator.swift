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
    case result(Bool, DifficultyLevel, WordCategory, String, String) // isCorrect, level, category, correctAnswer, braillePattern
}
