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
    
    let indexToDotNumber = [1, 4, 2, 5, 3, 6]
    
    var body: some View {
        let isSubmitDisabled = selectedDotsArray.allSatisfy { $0.isEmpty }
        
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("다음 문장부호의 점자를 찍어보세요.")
                    .font(.mainTextBold24)
                    .foregroundStyle(.blue00)
                
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
                
                ZStack {
                    HStack(spacing: 26) {
                        if currentCellIndex > 0 {
                            Button {
                                currentCellIndex -= 1
                            } label: {
                                Image(systemName: "chevron.left")
                                    .frame(width: 41, height: 70)
                                    .foregroundColor(.gray00)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.blue00, lineWidth: 2)
                                    )
                            }
                        } else {
                            Color.clear
                                .frame(width: 41, height: 70)
                        }
                        
                        Spacer()
                        
                        Button {
                            if !selectedDotsArray[currentCellIndex].isEmpty {
                                currentCellIndex += 1
                                
                                if currentCellIndex >= selectedDotsArray.count {
                                    selectedDotsArray.append([])
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .frame(width: 41, height: 70)
                                .foregroundColor(.gray00)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.blue00, lineWidth: 2)
                                )
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 26) {
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
                        }
                    }
                    .padding(.horizontal, 83)
                }
                .padding(.top, 42)
                
                HStack(spacing: 17) {
                    Button {
                        selectedDotsArray = [[]]
                        currentCellIndex = 0
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray01)
                            .frame(width: 168, height: 64)
                            .overlay {
                                Text("다시쓰기")
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
                                Text("작성완료")
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
    }
}

#Preview {
    PunctuationQuizView()
        .environment(NavigationCoordinator())
}
