//
//  SelectCard.swift
//  LearnDot
//
//  Created by 신혜연 on 5/20/25.
//

import SwiftUI

struct SelectCard: View {
    let title: String
    let description: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.gray06)
                .frame(width: 361, height: 116)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray04, lineWidth: 1)
                )
                .overlay {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.mainTextBold24)
                            .foregroundStyle(.blue00)
                            .accessibilityLabel(title.replacingOccurrences(of: "/", with: ", "))
                        
                        Text(description)
                            .font(.mainTextSemiBold16)
                            .foregroundStyle(.gray01)
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}
