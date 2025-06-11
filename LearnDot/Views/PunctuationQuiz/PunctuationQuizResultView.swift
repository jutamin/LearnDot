//
//  PunctuationQuizResultView.swift
//  LearnDot
//
//  Created by 신혜연 on 6/11/25.
//

import SwiftUI

struct PunctuationQuizResultView: View {
    @EnvironmentObject var viewModel: PunctuationQuizViewModel
    @Environment(NavigationCoordinator.self) private var coordinator
    
    let isCorrect: Bool
    
    var body: some View {
        let correctQuiz = viewModel.currentQuiz!
        
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
                        
                        Text("다음 문제에도 도전해볼까요?")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                    }
                } else {
                    VStack(spacing: 0){
                        Text("오답입니다 😭")
                            .font(.mainTextBold32)
                            .foregroundStyle(.white00)
                        
                        Group {
                            Text("정답의 점형 번호는 ")
                                .foregroundStyle(.white00)
                            + Text(dotNumbersText)
                                .foregroundStyle(.blue00)
                            + Text(" 입니다.")
                                .foregroundStyle(.white00)
                        }
                        .font(.mainTextSemiBold20)
                        .padding(.top, 8)
                        
                        Text("다음 문제는 맞춰봐요!")
                            .font(.mainTextSemiBold15)
                            .foregroundStyle(.gray02)
                            .padding(.top, 8)
                    }
                }
                
                Spacer().frame(height: 87)
                
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
