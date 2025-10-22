//
//  SelectLearning.swift
//  LearnDot
//
//  Created by 신혜연 on 10/21/25.
//

import SwiftUI

struct SelectLearning: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.gray06)
                .frame(width: 361, height: 64)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray04, lineWidth: 1)
                )
                .overlay {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.mainTextBold24)
                            .foregroundStyle(.blue00)
                    }
                    .padding(.leading, 28)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}
