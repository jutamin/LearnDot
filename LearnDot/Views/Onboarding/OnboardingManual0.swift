//
//  OnboardingManual0.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct OnboardingManual0: View {
    let onNext: () -> Void
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                
                Spacer().frame(height: 50)
                Spacer()
                
                Text("안녕하세요,\n점자학습앱\n")
                    .foregroundStyle(.white00)
                    .font(.mainTextBold32)
                + Text("'배우닷'")
                    .foregroundStyle(.blue00)
                    .font(.mainTextBold32)
                + Text(" 입니다.\n")
                    .foregroundStyle(.white00)
                    .font(.mainTextBold32)
                
                + Text("\n간단한 퀴즈 게임을 통해\n점자 학습을 진행할 수 있어요.\n")
                    .foregroundStyle(.white00)
                    .font(.mainTextBold24)
                
                + Text("\n다음 안내로 넘어가려면,\n화면 오른쪽 아래에 있는 ‘다음’ 버튼을 눌러주세요.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
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
                
                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    OnboardingManual0 {
        print("👉 다음 버튼 눌림")
    }
}
