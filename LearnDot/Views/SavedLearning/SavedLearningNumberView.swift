//
//  SavedLearningNumberView.swift
//  LearnDot
//
//  Created by 신혜연 on 11/17/25.
//

import SwiftUI
import SwiftData

struct SavedLearningNumberView: View {
    
    @Environment(NavigationCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<SavedLearningItem> { $0.unitType == "숫자" },
        sort: \.word,
        order: .forward
    ) private var savedNumbers: [SavedLearningItem]
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 82)
                
                if savedNumbers.isEmpty {
                    Spacer()
                    Text("저장된 항목이 없습니다.")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                        .accessibilityLabel("저장된 항목이 없습니다.")
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(savedNumbers) { item in
                                SelectLearning(
                                    title: item.word
                                ) {
                                    coordinator.push(AppDestination.savedLearningWordDetailView(item.persistentModelID))
                                }
                            }
                        }
                        .padding(.top, 30)
                        .padding(.horizontal, 27)
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}
