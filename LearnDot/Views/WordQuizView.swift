//
//  WordQuizView.swift
//  LearnDot
//
//  Created by 원주연 on 5/20/25.
//

import SwiftUI

// 정답/오답 네비게이션 라우터
enum AnswerResult: Hashable {
    case correct
    case wrong
    case home
}

struct WordQuizView: View {
    
    @State private var navigationPath: [AnswerResult] = []
    @State private var viewModel = WordQuizViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.black00
                VStack(spacing: 52) {
                    
                    VStack(spacing: 16) {
                        Text("어떤 글자일까요?")
                            .font(.mainTextBold24)
                            .foregroundStyle(.blue00)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 240, height: 112)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .overlay {
                                Image("wordQuizDot")
                            }
                    }
                    
                    
                    VStack(spacing: 16) {
                        ForEach(viewModel.currentQuiz.options.shuffled(), id: \.self) { option in
                            Button {
                                if viewModel.isCorrect(answer: option) {
                                    navigationPath.append(.correct)
                                } else {
                                    navigationPath.append(.wrong)
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue00)
                                    .frame(width: 280, height: 90)
                                    .overlay{
                                        Text(option)
                                            .font(.mainTextSemiBold32)
                                            .foregroundStyle(.white00)
                                    }
                            }
                        }
                    }
                    .navigationDestination(for: AnswerResult.self) { result in
                        if result == .correct {
                            WordQuizCorrectView()
                        } else {
                            WordQuizWrongView()
                        }
                    }
                    
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WordQuizView()
}
