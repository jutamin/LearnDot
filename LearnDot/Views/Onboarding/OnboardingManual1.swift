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
                    + Text("3단계로 나눠져 있어요.\n    원하는 난이도를 선택하세요.")
                        .foregroundStyle(.white00)
                    
                    Text("2. 학습 주제는 5개,\n")
                        .foregroundStyle(.white00)
                    + Text("    식품/화장실/철도/의약품/가전제품\n")
                        .foregroundStyle(.blue00)
                        .accessibilityLabel("식품, 화장실, 철도, 의약품, 가전제품")
                    + Text("    중에서 고를 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("3. 한 단어의 점형이 제시되고,\n    ")
                        .foregroundStyle(.white00)
                    + Text("점형 번호를 음성으로 ")
                        .foregroundStyle(.blue00)
                    + Text("들을 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("4. ")
                        .foregroundStyle(.white00)
                    + Text("4개의 보기 버튼 ")
                        .foregroundStyle(.blue00)
                    + Text("중,\n    점형과 일치하는 정답을 선택하세요.")
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

#Preview {
    OnboardingManual1 {
        print("👉 다음 버튼 눌림")
    } onBack: {
        print("👈 이전 버튼 눌림")
    }
    
}
