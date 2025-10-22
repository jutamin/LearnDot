//
//  SavedLearningWordDetailView.swift
//  LearnDot
//
//  Created by 신혜연 on 10/21/25.
//

//
//  SavedLearningWordDetailView.swift
//  LearnDot
//
//  Created by 신혜연 on 10/21/25.
//

import SwiftUI
import SwiftData

struct SavedLearningWordDetailView: View {
    
    // MARK: - Environment & State
    
    @Environment(NavigationCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingDeleteAlert: Bool = false
    
    // MARK: - Data
    
    @Query var itemQuery: [SavedLearningItem]
    
    private var item: SavedLearningItem? {
        itemQuery.first
    }
    
    init(itemID: PersistentIdentifier) {
        let id = itemID
        self._itemQuery = Query(filter: #Predicate<SavedLearningItem> {
            $0.persistentModelID == id
        })
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.black00.ignoresSafeArea()
            
            if let item = item {
                VStack(spacing: 0) {
                    
                    Spacer().frame(height: 30)
                    
                    mainCard(item: item)
                    
                    Spacer().frame(height: 30)
                    listenAgainButton(item: item)
                    
                    Spacer()
                }
            } else {
                Text("항목을 찾을 수 없습니다.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
            }
        }
    
        .alert("단어 삭제하기", isPresented: $isShowingDeleteAlert) {
            Button("확인", role: .destructive) {
                deleteItem()
            }
            Button("취소", role: .cancel) {}
        } message: {
            if let item = item {
                Text("'\(item.word)' 항목을 삭제할까요?")
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.white00)
                        .font(.system(size: 20))
                        .frame(width: 44, height: 44)
                }
            }
        }
    }
    
    @ViewBuilder
    private func mainCard(item: SavedLearningItem) -> some View {
        VStack(spacing: 0) {
            Text(item.word)
                .font(.mainTextExtraBold50)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Spacer()
            
            Text(item.braillePattern.trimmingCharacters(in: ["⠀"]))
                .font(.mainTextExtraBold70)
            
            Spacer()
            
            Text("(카드를 탭하면 소리가 나옵니다)")
                .font(.mainTextSemiBold15)
                .foregroundStyle(.gray02)
                .accessibilityHidden(true)
                .padding(.bottom, 20)
        }
        .foregroundStyle(.white00)
        .frame(width: 340, height: 380)
        .background(Color.gray06)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray04, lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private func listenAgainButton(item: SavedLearningItem) -> some View {
        Button {
            let brailleText = item.braillePattern.trimmingCharacters(in: ["⠀"])
            UIAccessibility.post(notification: .announcement, argument: brailleText)
        } label: {
            Text("다시 듣기")
                .font(.mainTextSemiBold20)
                .foregroundStyle(.black00)
                .frame(width: 340, height: 64)
                .background(Color.white00)
                .cornerRadius(20)
        }
    }
    
    // MARK: - Actions
    
    private func deleteItem() {
        if let item = item {
            modelContext.delete(item)
            coordinator.pop()
        }
    }
}
