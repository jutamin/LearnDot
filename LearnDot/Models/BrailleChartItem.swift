//
//  BrailleChartItem.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//

import Foundation

struct BrailleChartItem: Identifiable {
    let id = UUID()
    let title: String
    let braille: [Int]
}
