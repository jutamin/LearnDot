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
                Spacer().frame(height: 100)
                
                Text("문장부호 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundColor(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityFocused($isFocused)
                
                Spacer().frame(height: 57)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("1. 문제로 제시된 문장부호의 ")
                        .foregroundStyle(.white00)
                    + Text("점형을 직접 찍어보세요.")
                        .foregroundStyle(.blue00)
                    
                    Text("2. 1번부터 6번까지 버튼을 눌러 점을 입력할 수 있고,\n    다시 누르면 입력이 취소돼요.")
                        .foregroundStyle(.white00)
                    
                    Text("3. 2개의 점자 셀이 필요하다면 ")
                        .foregroundStyle(.white00)
                    + Text("'다음점자' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을,\n    이전 셀의 수정이 필요하다면 ")
                        .foregroundStyle(.white00)
                    + Text("'이전 점자' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을\n    사용하세요.")
                        .foregroundStyle(.white00)
                    
                    Text("4. 처음부터 다시하려면 ")
                        .foregroundStyle(.white00)
                    + Text("'다시찍기' 버튼을,\n")
                        .foregroundStyle(.blue00)
                    + Text("     답안을 제출하려면 ")
                        .foregroundStyle(.white00)
                    + Text("'찍기완료' 버튼")
                        .foregroundStyle(.blue00)
                    + Text("을 누르세요.")
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
                                Text("설명종료")
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
