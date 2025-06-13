//
//  OnboardingManual1.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct OnboardingManual1: View {
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
                    .accessibilityFocused($isFocused)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("1. 난이도는 ")
                        .foregroundStyle(.white00)
                    + Text("쉬움/보통/어려움 ")
                        .foregroundStyle(.blue00)
                        .accessibilityLabel("쉬움, 보통, 어려움")
                    + Text("3단계로 나누어져요.\n    학습 난이도를 선택할 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("2. 카테고리 5개가 주어져요.\n")
                        .foregroundStyle(.white00)
                    + Text("    (식품/화장실/철도/의약품/가전제품)\n")
                        .foregroundStyle(.blue00)
                        .accessibilityLabel("식품, 화장실, 철도, 의약품, 가전제품")
                    + Text("    관심있는 주제를 선택해주세요.")
                        .foregroundStyle(.white00)
                    
                    Text("3. 한 단어에 대한 점형이 주어져요.\n    어떤 글자일까요? 라는 문구 다음에,\n    주어진 ")
                        .foregroundStyle(.white00)
                    + Text("점형 번호를 음성으로 ")
                        .foregroundStyle(.blue00)
                    + Text("들을 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("4. ")
                        .foregroundStyle(.white00)
                    + Text("4개의 선택지 버튼 ")
                        .foregroundStyle(.blue00)
                    + Text("중, 문제 점형과 일치하는\n    선택지를 하나 골라주세요.")
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
