//
//  NumberQuizResultView.swift
//  LearnDot
//
//  Created by 신혜연 on 11/17/25.
//

import SwiftUI
import SwiftData

struct NumberQuizResultView: View {
    
    @Environment(NavigationCoordinator.self) private var coordinator
    
    let isCorrect: Bool
    let correctAnswer: String
    let braillePattern: String
    let myAnswerBraillePattern: String
    
    @Environment(\.modelContext) private var modelContext
    @State private var isBookmarked: Bool = false
    
    var currentLearningItemData: (word: String, unitType: String, title: String, braille: String) {
        (
            word: correctAnswer,
            unitType: "숫자",
            title: correctAnswer,
            braille: braillePattern
        )
    }
    
    private func fetchSavedItem() -> SavedLearningItem? {
        let word = currentLearningItemData.word
        let unitType = currentLearningItemData.unitType
        
        let predicate = #Predicate<SavedLearningItem> { item in
            item.word == word && item.unitType == unitType
        }
        
        var fetchDescriptor = FetchDescriptor(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            let items = try modelContext.fetch(fetchDescriptor)
            return items.first
        } catch {
            print("Failed to fetch item: \(error)")
            return nil
        }
    }
    
    func toggleBookmark() {
        if let itemToRemove = fetchSavedItem() {
            modelContext.delete(itemToRemove)
            isBookmarked = false
        } else {
            let newItem = SavedLearningItem(
                title: currentLearningItemData.title,
                unitType: currentLearningItemData.unitType,
                word: currentLearningItemData.word,
                braillePattern: currentLearningItemData.braille
            )
            modelContext.insert(newItem)
            isBookmarked = true
        }
    }
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                if isCorrect {
                    VStack(spacing: 13){
                        HStack {
                            Text("정답입니다!🎉")
                                .font(.mainTextBold32)
                                .foregroundStyle(.white00)
                                .accessibilityLabel("정답입니다")
                        }
                        
                        Text("다음 문제에도 도전해볼까요?")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                            .accessibilityHidden(true)
                    }
                    .accessibilityElement(children: .combine)
                } else {
                    VStack(spacing: 8){
                        Text("오답입니다 😭")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                            .accessibilityLabel("오답입니다")
                        
                        Group {
                            Text("정답은 ").foregroundStyle(.white00)
                            + Text(correctAnswer).foregroundStyle(.blue01)
                            + Text(" 입니다.").foregroundStyle(.white00)
                        }.font(.mainTextSemiBold20)
                        
                        Text("다음 문제는 맞춰봐요!")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                            .accessibilityHidden(true)
                    }
                    .accessibilityElement(children: .combine)
                }
                
                Spacer().frame(height: 52)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.gray06)
                        .frame(width: 240, height: 112)
                        .overlay {
                            Text(braillePattern.trimmingCharacters(in: ["⠀"]))
                                .font(.mainTextExtraBold50)
                                .accessibilitySortPriority(0)
                                .accessibilityLabel(
                                    braillePattern
                                        .trimmingCharacters(in: ["⠀"])
                                        .map { String($0) }
                                        .joined(separator: "\n\n\n")
                                )
                                .lineLimit(nil)
                        }
                    
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(.blue00)
                        .frame(width: 40, height: 27)
                        .overlay {
                            Text("정답")
                                .font(.mainTextSemiBold12)
                                .accessibilityLabel("정답 점형")
                                .accessibilitySortPriority(1)
                        }
                        .padding(.top, -70)
                        .padding(.leading, -106)
                }
                .accessibilityElement(children: .combine)
                
                if !isCorrect {
                    Spacer().frame(height: 22)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay {
                                Text(myAnswerBraillePattern.trimmingCharacters(in: ["⠀"]))
                                    .font(.mainTextExtraBold50)
                                    .accessibilitySortPriority(0)
                                    .accessibilityLabel(
                                        myAnswerBraillePattern
                                            .trimmingCharacters(in: ["⠀"])
                                            .map { String($0) }
                                            .joined(separator: "\n\n\n")
                                    )
                                    .lineLimit(nil)
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue00)
                            .frame(width: 76, height: 27)
                            .overlay {
                                Text("내가 고른 답")
                                    .font(.mainTextSemiBold12)
                                    .accessibilityLabel("내가 고른 답의 점형")
                                    .accessibilitySortPriority(1)
                            }
                            .padding(.top, -70)
                            .padding(.leading, -106)
                    }
                    .accessibilityElement(children: .combine)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    BookmarkButton(isBookmarked: $isBookmarked, tapAction: toggleBookmark)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                }
                
                HStack(spacing: 17) {
                    Button {
                        coordinator.popToRoot()
                    } label: {
                        QuitButtonCard()
                    }
                    
                    Button{
                        coordinator.push(AppDestination.numberQuiz)
                    } label: {
                        NextButtonCard()
                    }
                }
                
                Spacer().frame(height: 80)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            isBookmarked = (fetchSavedItem() != nil)
        }
    }
}
