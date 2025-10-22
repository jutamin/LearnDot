//
//  SavedLearningLevelView.swift
//  LearnDot
//
//  Created by 신혜연 on 10/22/25.
//

import SwiftUI
import SwiftData

struct SavedLearningLevelView: View {
    
    @Query(
        filter: #Predicate<SavedLearningItem> { $0.unitType == "난이도별" },
        sort: \.word, order: .forward
    )
    private var levelItems: [SavedLearningItem]
    
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 82)
                
                if levelItems.isEmpty {
                    Spacer()
                    Text("저장된 항목이 없습니다.")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(levelItems) { item in
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
}
