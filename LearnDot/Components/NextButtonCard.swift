//
//  BottomButtonCard.swift
//  LearnDot
//
//  Created by 원주연 on 5/26/25.
//

import SwiftUI

struct NextButtonCard: View {
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.blue00)
            .frame(width: 168, height: 64)
            .overlay{
                Text(title)
                    .font(.mainTextBold24)
                    .foregroundStyle(.white)
            }    }
}
