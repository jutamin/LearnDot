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
    let onSkip: () -> Void
    @AccessibilityFocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text("문장부호는 직접 점을 찍어보도록 구성되어 있어요.")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    Text("1~6번 점을 선택해 입력하고,\n필요하면 ")
                        .foregroundStyle(.white00)
                    + Text("‘다음 점자’")
                        .foregroundStyle(.blue00)
                    + Text(" 또는 ")
                        .foregroundStyle(.white00)
                    + Text("‘이전 점자’")
                        .foregroundStyle(.blue00)
                    + Text("로\n이동하며 수정할 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("문장부호를 실제처럼 조작하며\n익히는 학습이에요.")
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
    OnboardingManual2 {
        print("👉 다음 버튼 눌림")
    } onBack: {
        print("👈 이전 버튼 눌림")
    } onSkip: {
        print("⏭ 건너뛰기 눌림")
    }
}
