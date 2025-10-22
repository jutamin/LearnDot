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
    @State private var isTranslated = false
    @Environment(NavigationCoordinator.self) private var coordinator

    
    var body: some View {
        ZStack {
            Color.black00.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("점자 번역")
                    .font(.mainTextExtraBold36)
                    .foregroundStyle(.white00)
                    .padding(.leading, 27)
                    .padding(.bottom, 30)
                
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        // 상단 입력 박스
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray05)
                            .frame(height: 172)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray02, lineWidth: 1)
                            )
                            .overlay(
                                VStack(alignment: .leading) {
                                    TextField(
                                        "글자를 입력해주세요..",
                                        text: $text,
                                        prompt: Text("글자를 입력해주세요..").foregroundStyle(.gray03)
                                    )
                                    .font(.mainTextSemiBold24)
                                    .foregroundStyle(.white00)
                                }
                                    .padding(.leading, 16)
                            )
                        
                        // 하단 번역 결과 박스
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(height: 353)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(isTranslated ? Color.blue00 : Color.gray02, lineWidth: isTranslated ? 3 : 1)
                            )
                            .overlay(
                                VStack {
                                    let brailleChars = Array(trimmedBraille(translatedText))
                                    let rows = stride(from: 0, to: brailleChars.count, by: 5).map {
                                        Array(brailleChars[$0..<min($0 + 5, brailleChars.count)])
                                    }
                                    
                                    VStack(alignment: .center, spacing: 20) {
                                        ForEach(0..<rows.count, id: \.self) { rowIndex in
                                            HStack(spacing: 16) {
                                                ForEach(rows[rowIndex], id: \.self) { char in
                                                    let dots = brailleToDots(char)
                                                    BrailleCellView(dots: dots)
                                                }
                                            }
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                    }
                                    .padding(.vertical, 20)
                                }
                            )
                            .overlay(alignment: .top) {
                                Button(action: {
                                    translatedText = KorToBraille.korTranslate(text)
                                    isTranslated = true
                                }, label: {
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
                                        .offset(y: -35)
                                })
                                .disabled(text.isEmpty)
                                .accessibilityLabel("\(text) 번역")
                            }
                    }
                }
                .padding(.horizontal, 8)
                
                Spacer().frame(height: 16)
                
                HStack(spacing: 17) {
                    Button {
                        text = ""
                        translatedText = ""
                        isTranslated = false
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("검색 초기화")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.white)
                            }
                    }
                    
                    Button{
                        coordinator.popToRoot()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray01)
                            .frame(width: 168, height: 64)
                            .overlay{
                                Text("번역 종료")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.black00)
                            }
                    }
                }.padding(.horizontal, 20)
                
                Spacer().frame(height: 80)
            }
            .padding(.top, 28)
        }
    }
}

// MARK: - Helper: 마지막 점자 제거용
func trimmedBraille(_ text: String) -> String {
    if let last = text.last, last.unicodeScalars.first?.value == 0x2800 {
        return String(text.dropLast())
    } else {
        return text
    }
}

// MARK: - Helper: Braille to dots
func brailleToDots(_ brailleChar: Character) -> [Bool] {
    guard let scalarValue = brailleChar.unicodeScalars.first?.value else { return Array(repeating: false, count: 6) }
    let dotsMask = Int(scalarValue) - 0x2800
    return (0..<6).map { i in
        (dotsMask & (1 << i)) != 0
    }
}

// MARK: - Braille Cell View
struct BrailleCellView: View {
    let dots: [Bool]
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(spacing: 8) {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill(dots[i] ? Color.white00 : Color.gray05)
                        .frame(width: 14, height: 14)
                }
            }
            VStack(spacing: 8) {
                ForEach(3..<6, id: \.self) { i in
                    Circle()
                        .fill(dots[i] ? Color.white00 : Color.gray05)
                        .frame(width: 14, height: 14)
                }
            }
        }
        .padding(6)
    }
}

#Preview {
    TranslateView()
        .environment(NavigationCoordinator())
}
