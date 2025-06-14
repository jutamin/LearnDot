//
//  LearnDotApp.swift
//  LearnDot
//
//  Created by 원주연 on 5/15/25.
//

import SwiftUI

@main
struct LearnDotApp: App {
    @StateObject private var punctuationViewModel = PunctuationQuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            // HomeView(메인 페이지)로 돌려놓고 푸시할 것
            ContentView()
                .environmentObject(punctuationViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
