//
//  PunctuationQuizResultView.swift
//  LearnDot
//
//  Created by 신혜연 on 6/11/25.
//

import SwiftUI
import SwiftData

struct PunctuationQuizResultView: View {
    @EnvironmentObject var viewModel: PunctuationQuizViewModel
    @Environment(NavigationCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext
    @State private var isBookmarked: Bool = false
    @State private var quizToShow: BrailleWord?
    
    let isCorrect: Bool
    private var correctQuiz: BrailleWord {
            quizToShow ?? viewModel.currentQuiz!
        }
    
    var currentLearningItemData: (word: String, unitType: String, title: String, braille: String) {
        (
            word: correctQuiz.korean,
            unitType: "문장부호",
            title: correctQuiz.korean,
            braille: correctQuiz.braillePattern
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
        let dotArrays = viewModel.convertBraillePatternToDotArrays(correctQuiz.braillePattern)
        let dotNumbersText = dotArrays
            .map { $0.sorted().map { String($0) }.joined(separator: "-") }
            .joined(separator: ", ")
        
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 137)
                
                if isCorrect {
                    VStack(spacing: 13){
                        Text("정답입니다!🎉")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                            .accessibilityLabel("정답입니다")
                        
                        Text("다음 문제에도 도전해볼까요?")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                        
                    }
                    .accessibilityElement(children: .combine)
                } else {
                    VStack(spacing: 0){
                        VStack(spacing: 0) {
                            Text("오답입니다 😭")
                                .font(.mainTextBold32)
                                .foregroundStyle(.white00)
                                .accessibilityLabel("오답입니다")
                            
                            Group {
                                Text("정답의 점형 번호는 ")
                                    .foregroundStyle(.white00)
                                + Text(dotNumbersText)
                                    .foregroundStyle(.blue00)
                                    .accessibilityLabel(dotArrays
                                        .map { $0.sorted().map { String($0) }.joined(separator: " ") }
                                        .joined(separator: ", "))
                                + Text(" 입니다.")
                                    .foregroundStyle(.white00)
                            }
                            .font(.mainTextSemiBold20)
                            .padding(.top, 8)
                            
                            Text("다음 문제는 맞춰봐요!")
                                .font(.mainTextSemiBold15)
                                .foregroundStyle(.gray02)
                                .padding(.top, 8)
                                .accessibilityHidden(true)
                        }
                        .accessibilityElement(children: .combine)
                        
                        Button(action: {
                            coordinator.pop()
                        }) {
                            Text("점자 다시 찍어보기")
                                .font(.mainTextSemiBold16)
                                .frame(width: 168, height: 64)
                                .background(Color.gray06)
                                .cornerRadius(20)
                                .foregroundColor(.blue00)
                                .accessibilityLabel("점자 다시 찍어보기 버튼. 다음으로 넘기면 다음 문제를 풀 수 있고, 두번 탭하면 방금 문제의 점자를 다시 찍어볼 수 있어요.")
                        }
                        .padding(.top, 20)
                    }
                }
                
                Spacer().frame(height: isCorrect ? 87 : 23)
                
                VStack(spacing: 68) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.gray06)
                        .frame(width: 240, height: 72)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .overlay {
                            Text(correctQuiz.korean)
                                .font(.mainTextSemiBold24)
                                .foregroundStyle(.white00)
                        }
                        .overlay(alignment: .topTrailing) {
                            bookmarkButton
                                .padding(8)
                        }
                        .accessibilityHidden(true)
                    
                    let dotArrays = viewModel.convertBraillePatternToDotArrays(correctQuiz.braillePattern)
                    HStack(spacing: 12) {
                        ForEach(dotArrays.indices, id: \.self) { index in
                            DotCellView(dotIndexes: dotArrays[index])
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer().frame(height: 96)
                
                HStack(spacing: 17) {
                    Button {
                        viewModel.shouldGenerateNewQuiz = true
                        coordinator.popToRoot()
                    } label: {
                        QuitButtonCard()
                    }
                    
                    Button{
                        viewModel.shouldGenerateNewQuiz = true
                        coordinator.push(AppDestination.PunctuationQuiz)
                    } label: {
                        NextButtonCard()
                    }
                }
                
                Spacer().frame(height: 80)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if quizToShow == nil {
                quizToShow = viewModel.currentQuiz
            }
            isBookmarked = (fetchSavedItem() != nil)
        }
    }
    
    private var bookmarkButton: some View {
            Button {
                toggleBookmark()
            } label: {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 24))
                    .foregroundStyle(isBookmarked ? .blue01 : .gray03)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel(isBookmarked ? "북마크 해제" : "북마크 저장")
        }
}

struct DotCellView: View {
    let dotIndexes: [Int]

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                dotCircle(index: 0)
                dotCircle(index: 1)
            }
            HStack(spacing: 6) {
                dotCircle(index: 2)
                dotCircle(index: 3)
            }
            HStack(spacing: 6) {
                dotCircle(index: 4)
                dotCircle(index: 5)
            }
        }
        .padding(8)
        .background(Color.black00)
    }

    @ViewBuilder
    private func dotCircle(index: Int) -> some View {
        let dotIndexMapping = [0, 3, 1, 4, 2, 5]
        let checkIndex = dotIndexMapping[index] + 1
        Circle()
            .fill(dotIndexes.contains(checkIndex) ? Color.white00 : Color.gray05)
            .frame(width: 20, height: 20)
    }
}
