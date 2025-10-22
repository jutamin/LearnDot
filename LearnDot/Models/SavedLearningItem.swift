//
//  SavedLearningItem.swift
//  LearnDot
//
//  Created by 신혜연 on 10/22/25.
//

import Foundation
import SwiftData

@Model
final class SavedLearningItem {
    var title: String
    var unitType: String
    var word: String
    var braillePattern: String
    
    init(title: String, unitType: String, word: String, braillePattern: String) {
        self.title = title
        self.unitType = unitType
        self.word = word
        self.braillePattern = braillePattern
    }
}
