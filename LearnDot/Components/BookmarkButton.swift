//
//  BookmarkButton.swift
//  LearnDot
//
//  Created by 신혜연 on 11/26/25.
//

import SwiftUI
import UIKit

struct BookmarkButton: View {
    @Binding var isBookmarked: Bool
    var tapAction: () -> Void
    
    var body: some View {
        Button {
            toggleBookmarkWithFeedback()
        } label: {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .font(.system(size: 24))
                .foregroundStyle(isBookmarked ? .blue01 : .gray03)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .accessibilityLabel("학습 저장")
    }
    
    private func toggleBookmarkWithFeedback() {
        let feedbackMessage = isBookmarked ? "학습 저장 완료" : "학습 저장 취소"
        tapAction()
        UIAccessibility.post(notification: .announcement, argument: feedbackMessage)
    }
}
