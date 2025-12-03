//
//  BrailleDotsView.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//

import SwiftUI

struct BrailleDotsView: View {
    let pattern: [Int]
    
    private let columns = [
        GridItem(.fixed(12), spacing: 8),
        GridItem(.fixed(12), spacing: 8)
    ]

    var body: some View {
        let order = [0, 3, 1, 4, 2, 5]
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(order, id: \.self) { index in
                Circle()
                    .fill(pattern[index] == 1 ? Color.white00 : Color.gray05)
                    .frame(width: 16, height: 16)
            }
        }
        .padding(4)
    }
}
