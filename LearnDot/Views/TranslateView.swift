//
//  TranslateView.swift
//  LearnDot
//
//  Created by juyeun on 10/15/25.
//

import SwiftUI
import KorToBraille

struct TranslateView: View {
    @State var text: String = ""
    @State var translatedText: String = ""
    
    var body: some View {
        ZStack {
            Color.black00.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // 🔹 제목
                Text("점자 번역")
                    .font(.mainTextExtraBold36)
                    .foregroundStyle(.white00)
                    .padding(.leading, 27)
                    .padding(.bottom, 30)
                
                // 🔹 상단 + 하단 박스를 겹치는 ZStack
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        // 상단 Rectangle
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray05)
                            .frame(height: 172)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray02, lineWidth: 1)
                            )
                            .overlay(
                                VStack(alignment: .leading, spacing: 6) {
                                    TextField(
                                        "글자를 입력해주세요..",
                                        text: $text,
                                        prompt: Text("글자를 입력해주세요..").foregroundStyle(.gray03)
                                    )
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
                                }
                                    .padding(.leading, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            )
                        
                        // 하단 Rectangle
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(height: 353)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray02, lineWidth: 1)
                            )
                            .overlay(
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(translatedText)
                                        .font(.mainTextSemiBold24)
                                        .foregroundStyle(.white00)
                                }
                                    .padding(.leading, 16)
                                    .frame(maxWidth: .infinity)
                            )
                            .overlay(alignment: .top) {
                                Button(action: {
                                    translatedText = KorToBraille.korTranslate(text)
                                }) {
                                    Circle()
                                        .fill(text.isEmpty ? Color.gray01 : Color.blue01)
                                        .frame(width: 70, height: 70)
                                        .overlay(
                                            Image(systemName: "chevron.down")
                                                .resizable()
                                                .foregroundStyle(text.isEmpty ? Color.gray02 : Color.white00)
                                                .frame(width: 30, height: 16)
                                                .padding(.top, 5)
                                        )
                                    // 상단박스의 아래쪽 경계선 중앙에 겹치게
                                        .offset(y: -35)
                                }
                                .disabled(text.isEmpty)
                            }
                    }
                }
                .padding(.horizontal, 8)
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    TranslateView()
}
