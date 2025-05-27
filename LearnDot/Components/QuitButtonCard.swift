//
//  QuitButtonCard.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import SwiftUI

struct QuitButtonCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.gray01)
            .frame(width: 168, height: 64)
            .overlay{
                Text("학습 종료")
                    .font(.mainTextBold24)
                    .foregroundStyle(.black00)
            }
    }
}
