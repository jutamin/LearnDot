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
    let onSkip: () -> Void
    @AccessibilityFocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text("배우닷에서는\n점형을 자연스럽게\n익힐 수 있어요.")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                    .accessibilityFocused($isFocused)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("기초 점형(초성·중성·종성),\n난이도별 생활 단어(5개 카테고리),\n숫자 점형,\n약자·약어까지")
                        .foregroundStyle(.white00)
                        .accessibilityLabel("초성, 중성, 종성 점형, 난이도별 생활 단어, 숫자, 그리고 약자와 약어까지")
                    
                    Text("모두 ")
                        .foregroundStyle(.white00)
                    + Text("4지선다 퀴즈 형식")
                        .foregroundStyle(.blue00)
                    + Text("으로 학습할 수 있어요.")
                        .foregroundStyle(.white00)
                }
                .font(.mainTextSemiBold18)
                
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

                Button {
                    onSkip()
                } label: {
                    Text("설명 건너뛰기")
                        .font(.mainTextSemiBold15)
                        .foregroundStyle(.gray02)
                        .underline()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 16)

                Spacer().frame(height: 60)
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
    } onSkip: {
        print("⏭ 건너뛰기 눌림")
    }
}
