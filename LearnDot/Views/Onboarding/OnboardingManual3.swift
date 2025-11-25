//
//  OnboardingManual3.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct OnboardingManual3: View {
    let onNext: () -> Void
    let onBack: () -> Void
    @AccessibilityFocusState private var isFocused: Bool
    
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text("퀴즈를 풀고,\n다시 보고 싶은 문제는\n저장할 수 있어요.")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                    .accessibilityFocused($isFocused)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("헷갈리는 점형은 저장해두고\n")
                        .foregroundStyle(.white00)
                    + Text("저장한 학습")
                        .foregroundStyle(.blue00)
                    + Text("에서 반복해서 익혀보세요.")
                        .foregroundStyle(.white00)
                    
                    Text("홈 화면에서 세 손가락으로\n")
                        .foregroundStyle(.white00)
                    + Text("왼쪽")
                        .foregroundStyle(.blue00)
                    + Text("으로 쓸어넘기면\n")
                        .foregroundStyle(.white00)
                    + Text("저장한 학습")
                        .foregroundStyle(.blue00)
                    + Text("으로 바로 이동해요.")
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
    OnboardingManual3 {
        print("👉 다음 버튼 눌림")
    } onBack: {
        print("👈 이전 버튼 눌림")
    }
    
}
