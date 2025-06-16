//
//  PunctuationQuizView.swift
//  LearnDot
//
//  Created by 신혜연 on 6/3/25.
//

import SwiftUI

struct PunctuationQuizView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    @EnvironmentObject var viewModel: PunctuationQuizViewModel
    
    @State private var selectedDotsArray: [[Int]] = [[]]
    @State private var currentCellIndex: Int = 0
    @AccessibilityFocusState private var focusedDot: Int?
    
    let indexToDotNumber = [1, 4, 2, 5, 3, 6]
    let totalDots = 6
    
    var body: some View {
        let isSubmitDisabled = selectedDotsArray.allSatisfy { $0.isEmpty }
        
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 0){
                    Text("다음 문장부호의 점자를 찍어보세요.")
                        .font(.mainTextBold24)
                        .foregroundStyle(.blue00)
                        .accessibilityLabel("주어지는 문장부호를 듣고 점자를 찍어보세요.")
                    
                    if let quiz = viewModel.currentQuiz {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 72)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay {
                                Text(quiz.korean)
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
                            }
                            .padding(.top, 12)
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilitySortPriority(3)
                
                HStack(spacing: 26) {
                    /// 이전 점자 셀
                    Button {
                        currentCellIndex -= 1
                        focusedDot = 1
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 41, height: 70)
                            .foregroundColor(currentCellIndex == 0 ? .clear : .gray00)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(currentCellIndex == 0 ? .clear : Color.blue00, lineWidth: 2)
                            )
                            .accessibilityLabel("이전 점자셀로 이동")
                    }
                    .disabled(currentCellIndex == 0)
                    .accessibilityHidden(currentCellIndex == 0) // ⬅️ 비활성화 시 VoiceOver에서 숨김
                    .accessibilityLabel("이전 점자셀로 이동")
                    .accessibilitySortPriority(1)
                    
                    /// 6점 셀
                    LazyVGrid(columns: [GridItem(.fixed(100), spacing: 26),
                                        GridItem(.fixed(100), spacing: 26)], spacing: 26) {
                        ForEach(0..<6) { index in
                            let dotNumber = indexToDotNumber[index]
                            Circle()
                                .fill(selectedDotsArray[currentCellIndex].contains(dotNumber) ? Color.white00 : Color.gray05)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    if selectedDotsArray[currentCellIndex].contains(dotNumber) {
                                        selectedDotsArray[currentCellIndex].removeAll { $0 == dotNumber }
                                    } else {
                                        selectedDotsArray[currentCellIndex].append(dotNumber)
                                    }
                                }
                                .accessibilityElement()
                                .accessibilityLabel("\(dotNumber)번 점자")
                                .accessibilitySortPriority(Double(totalDots + 1 - dotNumber))
                                .accessibilityFocused($focusedDot, equals: dotNumber)
                        }
                    }
                                        .accessibilitySortPriority(2)
                    
                    /// 다음 점자셀로 이동
                    Button {
                        if !selectedDotsArray[currentCellIndex].isEmpty {
                            currentCellIndex += 1
                            
                            if currentCellIndex >= selectedDotsArray.count {
                                selectedDotsArray.append([])
                            }
                            
                            focusedDot = 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .frame(width: 41, height: 70)
                            .foregroundColor(.gray00)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue00, lineWidth: 2)
                            )
                            .accessibilityLabel("다음 점자셀로 이동")
                    }
                    .accessibilitySortPriority(0)
                }
                .padding(.top, 42)
                
                /// 다시찍기, 찍기완료
                HStack(spacing: 17) {
                    Button {
                        selectedDotsArray = [[]]
                        currentCellIndex = 0
                        focusedDot = 1
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray01)
                            .frame(width: 168, height: 64)
                            .overlay {
                                Text("다시찍기")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.black00)
                            }
                    }
                    
                    Button {
                        let isCorrect = viewModel.isAnswerCorrect(selectedDotsArray: selectedDotsArray)
                        coordinator.push(AppDestination.PunctuationResult(isCorrect))
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(isSubmitDisabled ? .gray04 : .blue01)
                            .frame(width: 168, height: 64)
                            .overlay {
                                Text("찍기완료")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(isSubmitDisabled ? .gray02 : .white00)
                            }
                    }
                    .disabled(isSubmitDisabled)
                }
                .padding(.top, 46)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if viewModel.shouldGenerateNewQuiz {
                viewModel.generateNewQuiz()
            }
            selectedDotsArray = [[]]
            currentCellIndex = 0
        }
    }
}

#Preview {
    PunctuationQuizView()
        .environmentObject(PunctuationQuizViewModel())
        .environment(NavigationCoordinator())
}
