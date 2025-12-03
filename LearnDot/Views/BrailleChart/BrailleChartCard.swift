//
//  BrailleChartCard.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//
import SwiftUI
import KorToBraille

struct BrailleChartCard: View {
    let item: BrailleChartItem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.gray06)
            .frame(width: 166, height: 156)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray04, lineWidth: 1)
            )
            .overlay {
                let cells = stride(from: 0, to: item.braille.count, by: 6).map {
                    Array(item.braille[$0 ..< min($0 + 6, item.braille.count)])
                }
                VStack(spacing: 4) {
                    Text(item.title)
                        .font(.mainTextBold40)
                        .foregroundStyle(.blue00)
                    HStack(spacing: -50) {
                        ForEach(cells.indices, id: \.self) { idx in
                            BrailleDotsView(pattern: cells[idx])
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .contentShape(Rectangle())
        // MARK: - VoiceOver Accessibility 설정
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(item.title)
            .accessibilityAddTraits(.isButton)
            .accessibilityAction {
                let message = brailleDotsSpeech
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    UIAccessibility.post(notification: .announcement, argument: message)
                }
            }
    }
    
    private var brailleDotsSpeech: String {
        var resultString = ""
        
        let chunks = stride(from: 0, to: item.braille.count, by: 6).map {
            Array(item.braille[$0 ..< min($0 + 6, item.braille.count)])
        }
        
        for chunk in chunks {
            var value = 0x2800
            
            for (index, bit) in chunk.enumerated() {
                if bit == 1 {
                    value += (1 << index)
                }
            }
            
            if let scalar = UnicodeScalar(value) {
                resultString.append(Character(scalar))
            }
        }
        return resultString.toBrailleDotSpeech()
    }
}

struct BraillePatternParser {
    static func parse(_ braille: String) -> [Int] {
        guard let scalar = braille.unicodeScalars.first else { return [] }
        
        let value = Int(scalar.value) - 0x2800
        
        var bits = [Int]()
        for i in 0..<6 {
            let bit = (value >> i) & 1
            bits.append(bit)
        }
        return bits
    }
}

enum ChoseongData {
    static let items: [BrailleChartItem] = kor_cho.map { (key, value) in
        BrailleChartItem(
            title: key,
            braille: BraillePatternParser.parse(value)
        )
    }
        .sorted { $0.title < $1.title }
}

enum JungseongData {
    static let items: [BrailleChartItem] = kor_jung.map { (key, value) in
        
        let cells = value.map { BraillePatternParser.parse(String($0)) }
        let flatten = cells.flatMap { $0 }
        
        return BrailleChartItem(
            title: key,
            braille: flatten
        )
    }
        .sorted { $0.title < $1.title }
}

enum JongseongData {
    static let items: [BrailleChartItem] = kor_jong.map { (key, value) in
        BrailleChartItem(
            title: key,
            braille: BraillePatternParser.parse(value)
        )
    }
        .sorted { $0.title < $1.title }
}

enum NumberData {
    static let numbers: [String: String] = [
        "0": "⠼⠚",
        "1": "⠼⠁",
        "2": "⠼⠃",
        "3": "⠼⠉",
        "4": "⠼⠙",
        "5": "⠼⠑",
        "6": "⠼⠋",
        "7": "⠼⠛",
        "8": "⠼⠓",
        "9": "⠼⠊"
    ]
    
    static let items: [BrailleChartItem] = numbers.map { key, value in
        let cells = value.map { BraillePatternParser.parse(String($0)) }
        let flatten = cells.flatMap { $0 }
        return BrailleChartItem(title: key, braille: flatten)
    }
        .sorted { $0.title < $1.title }
}

enum AbbreviationData {
    static let abbreviations: [String] = [
        "가", "나", "다", "마", "바", "사", "자", "카", "타", "파", "하",
        "억", "언", "얼", "연", "열", "영",
        "옥", "온", "옹", "운", "울", "은", "을", "인",
        "것"
    ]
    
    static let items: [BrailleChartItem] = abbreviations.map { word in
        let brailleString = KorToBraille.korTranslate(word)
        let trimmed = String(brailleString.dropLast())
        let cells = trimmed.map { BraillePatternParser.parse(String($0)) }
        let flatten = cells.flatMap { $0 }
        return BrailleChartItem(title: word, braille: flatten)
    }
        .sorted { $0.title < $1.title }
}

enum contractedData {
    static let items: [BrailleChartItem] = chart_abbreviations.map { (key, value) in
        
        let cells = value.map { BraillePatternParser.parse(String($0)) }
        
        let flatten = cells.flatMap { $0 }
        
        return BrailleChartItem(
            title: key,
            braille: flatten
        )
    }
        .sorted { $0.title < $1.title }
}

#Preview {
    BrailleChartView(category: .abbreviation)
        .environment(NavigationCoordinator())
}
