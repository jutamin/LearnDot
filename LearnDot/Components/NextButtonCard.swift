//
//  NextButtonCard.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import SwiftUI

struct NextButtonCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.blue01)
            .frame(width: 168, height: 64)
            .overlay{
                Text("다음 문제")
                    .font(.mainTextBold24)
                    .foregroundStyle(.white)
            }
    }
}
