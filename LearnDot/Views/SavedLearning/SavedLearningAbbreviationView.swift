//
//  SavedLearningAbbreviationView.swift
//  LearnDot
//
//  Created by juyeun on 11/18/25.
//

import SwiftUI
import SwiftData

struct SavedLearningAbbreviationView: View {
    
    @Query(
        filter: #Predicate<SavedLearningItem> { $0.unitType == "약자약어" },
        sort: \.word, order: .forward
    )
    private var abbreviationItems: [SavedLearningItem]
    @Environment(NavigationCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            Color.black00
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 82)
                
                if abbreviationItems.isEmpty {
                    Spacer()
                    Text("저장된 항목이 없습니다.")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(abbreviationItems) { item in
                                SelectLearning(
                                    title: item.word
                                ) {
                                    coordinator.push(AppDestination.savedLearningWordDetailView(item.persistentModelID))
                                }
                            }
                        }
                        .padding(.top, 30)
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    private func deleteItem(_ item: SavedLearningItem) {
        modelContext.delete(item)
    }
}
