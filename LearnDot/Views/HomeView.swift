//
//  HomeView.swift
//  LearnDot
//
//  Created by 신혜연 on 5/26/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 82)
                
                HStack {
                    Text("점형 학습 게임")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                    
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.info)
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 38, height: 42)
                            .foregroundStyle(.white00)
                    }
                    .accessibilityLabel("도움말")
                }
                .padding(.horizontal, 27)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        SelectCard(
                            title: "기초단계 점형 학습",
                            description: "한글 자모 점형 맞추기"
                        ) {
                            coordinator.push(AppDestination.basicUnit)
                        }
                        
                        SelectCard(
                            title: "난이도별 점형 학습",
                            description: "단계별로 점형 맞추기"
                        ) {
                            coordinator.push(AppDestination.wordLevel)
                        }
                        
                        SelectCard(
                            title: "문장부호 점형 학습",
                            description: "문장부호 퀴즈 맞추기"
                        ) {
                            coordinator.push(AppDestination.PunctuationQuiz)
                        }
                        
                        SelectCard(
                            title: "숫자 점형 학습",
                            description: "숫자 퀴즈 맞추기"
                        ) {
                            coordinator.push(AppDestination.numberQuiz)
                        }
                        
                        SelectCard(
                            title: "약자, 약어 점형 학습",
                            description: "약자, 약어 퀴즈 맞추기"
                        ) {
                            coordinator.push(AppDestination.abbreviationUnit)
                        }
                    }
                    .padding(.top, 30)
                }
                Spacer()
                
                HStack(spacing: 13) {
                    Button {
                        coordinator.push(AppDestination.translateView)
                    } label: {
                        Text("< 점자 번역")
                            .font(.mainTextBold24)
                            .foregroundStyle(.black00)
                            .frame(width: 167, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.gray01)
                            )
                            .accessibilityLabel("점자 번역")
                    }
                    
                    Button {
                        coordinator.push(AppDestination.savedLearningView)
                    } label: {
                        Text("저장한 학습 >")
                            .font(.mainTextBold24)
                            .foregroundStyle(.white00)
                            .frame(width: 167, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue01)
                            )
                            .accessibilityLabel("저장한 학습")
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .ignoresSafeArea()
        .accessibilityScrollAction { edge in
            switch edge {
            case .trailing:
                // 화면상 왼쪽에 있는 '점자 번역'으로 이동
                coordinator.push(AppDestination.translateView)
            case .leading:
                // 화면상 오른쪽에 있는 '저장한 학습'으로 이동
                coordinator.push(AppDestination.savedLearningView)
            default:
                break
            }
        }
    }
}
