//
//  OnboardingManual2.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct OnboardingManual2: View {
    let onNext: () -> Void
    let onBack: () -> Void
    @AccessibilityFocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 100)
                
                Text("난이도별 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("5. 정답을 맞혔을 경우, 축하 메시지와\n    정답 점형을 다시 들어볼 수 있어요. ")
                        .foregroundStyle(.white00)
                        .accessibilityFocused($isFocused)
                    
                    Text("6. 오답을 골랐을 경우, 안내 메시지와 정답,\n    내가 고른 답의 점형을 다시 들어볼 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("7. 학습을 그만하거나, 난이도 또는 카테고리를\n    바꾸고 싶다면, ")
                        .foregroundStyle(.white00)
                    + Text("'학습종료' 버튼 ")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.\n    계속해서 다음 문제를 풀어보고 싶다면,\n")
                        .foregroundStyle(.white00)
                    + Text("    '다음문제' 버튼 ")
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.")
                        .foregroundStyle(.white00)
                }
                .font(.mainTextSemiBold16)
                
                Spacer()
                
                HStack(spacing: 17) {
                    Button {
                        onBack()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("이전")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.black00)
                            }
                    }
                    
                    Button {
                        onNext()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("다음")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.white)
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            // 다음 화면으로 이동했을 때 VoiceOver 포커스를 첫 텍스트로 이동
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isFocused = true
                UIAccessibility.post(notification: .layoutChanged, argument: nil)
            }
        }
    }
}

