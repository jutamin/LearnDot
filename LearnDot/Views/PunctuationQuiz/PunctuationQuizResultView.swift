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

    var dotNumbersText: String {
        let dotArrays = viewModel.convertBraillePatternToDotArrays(correctQuiz.braillePattern)
        return dotArrays
            .map { $0.sorted().map { String($0) }.joined(separator: "-") }
            .joined(separator: ", ")
    }
    
    var dotNumbersAccessibilityText: String {
        let dotArrays = viewModel.convertBraillePatternToDotArrays(correctQuiz.braillePattern)
        return dotArrays
            .map { $0.sorted().map { String($0) }.joined(separator: " ") }
            .joined(separator: ", ")
    }
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 137)
                
                // 정답/오답 뷰 분리 호출
                if isCorrect {
                    correctView
                } else {
                    incorrectView
                }
                
                Spacer().frame(height: isCorrect ? 87 : 23)
                
                // 점자 카드 뷰 분리 호출
                brailleCardView
                
                Spacer()
                
                HStack {
                    Spacer()
                    BookmarkButton(isBookmarked: $isBookmarked, tapAction: toggleBookmark)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                }
                
                // 하단 버튼 그룹
                bottomButtons
                
                Spacer().frame(height: 80)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    coordinator.pop()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.backward")
                        Text("뒤로")
                    }
                    .foregroundColor(.white00)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.shouldGenerateNewQuiz = true
                    coordinator.popToRoot()
                } label: {
                    Image(systemName: "house.fill")
                        .foregroundColor(.white00)
                }
            }
        }
        .onAppear {
            if quizToShow == nil {
                quizToShow = viewModel.currentQuiz
            }
            isBookmarked = (fetchSavedItem() != nil)
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var correctView: some View {
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
    }
    
    @ViewBuilder
    private var incorrectView: some View {
        VStack(spacing: 0){
            VStack(spacing: 0) {
                Text("오답입니다 😭")
                    .font(.mainTextBold32)
                    .foregroundStyle(.white00)
                    .accessibilityLabel("오답입니다")
                
                answerInfoText
                    .padding(.top, 8)
                
                Text("점판에 읽을 때는 쓸 때와 좌우가 반전됩니다.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                    .padding(.top, 8)
            }
            .accessibilityElement(children: .combine)
            .accessibilitySortPriority(10)
            
            Button(action: {
                coordinator.pop()
            }) {
                Text("점자 다시 찍어보기")
                    .font(.mainTextSemiBold16)
                    .frame(width: 168, height: 64)
                    .background(Color.gray06)
                    .cornerRadius(20)
                    .foregroundColor(.blue00)
            }
            .padding(.top, 20)
            .accessibilityLabel("점자 다시 찍어보기")
            .accessibilityHint("방금 문제의 점자를 다시 찍어볼 수 있습니다.")
        }
    }
    
    @ViewBuilder
    private var answerInfoText: some View {
        VStack {
            Group {
                Text("정답의 점형 번호는 ")
                    .foregroundStyle(.white00)
                + Text(dotNumbersText)
                    .foregroundStyle(.blue00)
                + Text(" 입니다.")
                    .foregroundStyle(.white00)
            }
            .font(.mainTextSemiBold20)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("정답의 점형 번호는 \(correctQuiz.braillePattern.toBrailleDotSpeech()) 입니다.")
    }
    
    @ViewBuilder
    private var brailleCardView: some View {
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
                .accessibilityHidden(true)
            
            let dotArrays = viewModel.convertBraillePatternToDotArrays(correctQuiz.braillePattern)
            HStack(spacing: 12) {
                ForEach(dotArrays.indices, id: \.self) { index in
                    DotCellView(dotIndexes: dotArrays[index])
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(correctQuiz.braillePattern.toBrailleDotSpeech())
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private var bottomButtons: some View {
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
        let writingLayout = [4, 1, 5, 2, 6, 3]
        let checkNumber = writingLayout[index]
        
        Circle()
            .fill(dotIndexes.contains(checkNumber) ? Color.white00 : Color.gray05)
            .frame(width: 20, height: 20)
    }
}
