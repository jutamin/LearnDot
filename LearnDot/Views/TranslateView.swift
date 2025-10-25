//
//  TranslateView.swift
//  LearnDot
//
//  Created by juyeun on 10/25/25.
//

import SwiftUI
import KorToBraille

struct TranslateView: View {
    @State private var text: String = ""
    @State private var translatedText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @AccessibilityFocusState private var isResultFocused: Bool
    @Environment(NavigationCoordinator.self) private var coordinator
    
    // 초성·중성 데이터
    let korCho: [String: String] = [
        "ㄱ": "⠈", "ㄴ": "⠉", "ㄷ": "⠊", "ㄹ": "⠐", "ㅁ": "⠑",
        "ㅂ": "⠘", "ㅅ": "⠠", "ㅇ": " ", "ㅈ": "⠨", "ㅊ": "⠰",
        "ㅋ": "⠋", "ㅌ": "⠓", "ㅍ": "⠙", "ㅎ": "⠚",
        "ㄲ": "⠠⠈", "ㄸ": "⠠⠊", "ㅃ": "⠠⠘", "ㅆ": "⠠⠠", "ㅉ": "⠠⠨"
    ]
    
    let korJung: [String: String] = [
        "ㅏ": "⠣", "ㅑ": "⠜", "ㅓ": "⠎", "ㅕ": "⠱", "ㅗ": "⠥",
        "ㅛ": "⠬", "ㅜ": "⠍", "ㅠ": "⠩", "ㅡ": "⠪", "ㅣ": "⠕",
        "ㅐ": "⠗", "ㅔ": "⠝", "ㅒ": "⠜⠗", "ㅖ": "⠌", "ㅘ": "⠧",
        "ㅙ": "⠧⠗", "ㅚ": "⠽", "ㅝ": "⠏", "ㅞ": "⠏⠗",
        "ㅟ": "⠍⠗", "ㅢ": "⠺"
    ]
    
    var body: some View {
        ZStack {
            Color.black00.ignoresSafeArea()
            VStack(spacing: 0) {
                // MARK: - Title
                Text("점자 번역")
                    .font(.mainTextExtraBold36)
                    .foregroundStyle(.white00)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 27)
                
                Spacer().frame(height: 30)
                
                // MARK: - 상단 입력박스
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray05)
                    .frame(height: 172)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray02, lineWidth: 1)
                    )
                    .overlay(
                        TextField("글자를 입력해주세요..", text: $text, prompt: Text("글자를 입력해주세요..").foregroundStyle(.gray03))
                            .font(.mainTextSemiBold24)
                            .foregroundStyle(.white00)
                            .focused($isTextFieldFocused)
                            .padding(.leading, 16)
                    )
                    .padding(.horizontal, 8)
                
                // MARK: - 하단 번역 결과 박스
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray06)
                    .frame(height: 353)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(!translatedText.isEmpty ? Color.blue00 : Color.gray02,
                                    lineWidth: !translatedText.isEmpty ? 3 : 1)
                    )
                    .overlay(
                        VStack(spacing: 20) {
                            if translatedText.isEmpty {
                                Text("번역 결과가 여기에 표시됩니다.")
                                    .foregroundStyle(.gray03)
                            } else {
                                let brailleChars = Array(trimmedBraille(translatedText))
                                let rows = stride(from: 0, to: brailleChars.count, by: 5).map {
                                    Array(brailleChars[$0..<min($0 + 5, brailleChars.count)])
                                }
                                
                                VStack(spacing: 20) {
                                    ForEach(0..<rows.count, id: \.self) { rowIndex in
                                        HStack(spacing: 16) {
                                            ForEach(rows[rowIndex], id: \.self) { char in
                                                BrailleCellView(dots: brailleToDots(char))
                                            }
                                        }
                                    }
                                }
                                .accessibilityElement(children: .combine)
                            }
                        }
                        .padding()
                        .accessibilityElement(children: .contain)
                        .accessibilityFocused($isResultFocused)
                        .accessibilityLabel(generateBrailleLabel(from: translatedText))
                    )
                    .overlay(alignment: .top) {
                        Button {
                            translateText()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isResultFocused = true
                            }
                        } label: {
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
                        }
                        .disabled(text.isEmpty)
                        .accessibilityLabel("번역")
                    }
                    .padding(.horizontal, 8)
                
                // MARK: - Buttons
                HStack(spacing: 16) {
                    Button("검색 초기화") {
                        text = ""
                        translatedText = ""
                        isTextFieldFocused = true
                    }
                    .font(.mainTextBold24)
                    .frame(width: 160, height: 64)
                    .background(Color.blue01, in: RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                    
                    Button("번역 종료") {
                        coordinator.popToRoot()
                    }
                    .font(.mainTextBold24)
                    .frame(width: 160, height: 64)
                    .background(Color.gray01, in: RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.black00)
                }
                .padding(.top, 16)
                
                Spacer().frame(height: 80)
            }
            .padding(.top, 20)
        }
    }
    
    // MARK: - Translation Logic
    private func translateText() {
        var result = ""
        for char in text {
            let s = String(char)
            if let b = korCho[s] ?? korJung[s] {
                result += b
            } else {
                result += trimmedBraille(KorToBraille.korTranslate(s))
            }
        }
        translatedText = result
    }
    
    // MARK: - Accessibility Label
    private func generateBrailleLabel(from text: String) -> String {
        let chars = Array(trimmedBraille(text))
        guard !chars.isEmpty else { return "번역 결과가 없습니다." }
        
        return chars.map { char in
            if char == " " { return "띄어쓰기" }
            let dots = brailleToDots(char)
            let dotNums = dots.indices.filter { dots[$0] }.map { "\($0 + 1)" }
            return dotNums.isEmpty ? "빈 칸" : dotNums.joined(separator: ", ") + "번 점"
        }.joined(separator: ", ")
    }
}

// MARK: - Helper Functions
private func trimmedBraille(_ text: String) -> String {
    if let last = text.last, last.unicodeScalars.first?.value == 0x2800 {
        return String(text.dropLast())
    }
    return text
}

private func brailleToDots(_ char: Character) -> [Bool] {
    guard let value = char.unicodeScalars.first?.value,
          (0x2800...0x28FF).contains(value) else {
        return Array(repeating: false, count: 6)
    }
    let mask = Int(value) - 0x2800
    return (0..<6).map { (mask & (1 << $0)) != 0 }
}

// MARK: - Braille Cell View
struct BrailleCellView: View {
    let dots: [Bool]
    
    private var label: String {
        let onDots = dots.indices.filter { dots[$0] }.map { "\($0 + 1)" }
        return onDots.isEmpty ? "빈 칸" : onDots.joined(separator: ", ") + "번 점"
    }
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(spacing: 8) {
                ForEach(0..<3, id: \.self) { i in
                    Circle().fill(dots[i] ? .white00 : .gray05)
                        .frame(width: 14, height: 14)
                }
            }
            VStack(spacing: 8) {
                ForEach(3..<6, id: \.self) { i in
                    Circle().fill(dots[i] ? .white00 : .gray05)
                        .frame(width: 14, height: 14)
                }
            }
        }
        .padding(6)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
    }
}

#Preview {
    TranslateView()
        .environment(NavigationCoordinator())
}
