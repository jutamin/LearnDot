//
//  OnboardingManual4.swift
//  LearnDot
//
//  Created by juyeun on 11/26/25.
//

import SwiftUI

struct OnboardingManual4: View {
    let onNext: () -> Void
    let onBack: () -> Void
    @AccessibilityFocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text("마지막으로,\n점자 번역 기능이 있어요.")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                    .accessibilityFocused($isFocused)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("입력한 한글을 \n")
                        .foregroundStyle(.white00)
                    + Text("점자로 변환")
                        .foregroundStyle(.blue00)
                    + Text("해주어,\n실생활에서 점자를 확인하는 데\n사용할 수 있어요.")
                        .foregroundStyle(.white00)
                    
                    Text("홈 화면에서 세 손가락으로\n")
                        .foregroundStyle(.white00)
                    + Text("오른쪽")
                        .foregroundStyle(.blue00)
                    + Text("으로 쓸어넘기면\n")
                        .foregroundStyle(.white00)
                    + Text("점자 번역")
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
                                Text("설명 종료")
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
    OnboardingManual4 {
        print("👉 다음 버튼 눌림")
    } onBack: {
        print("👈 이전 버튼 눌림")
    }
}
