//
//  LearnDotApp.swift
//  LearnDot
//
//  Created by 원주연 on 5/15/25.
//

import SwiftUI
import SwiftData

@main
struct LearnDotApp: App {
    @StateObject private var punctuationViewModel = PunctuationQuizViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SavedLearningItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(punctuationViewModel)
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
