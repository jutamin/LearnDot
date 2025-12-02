//
//  BrailleChartCard.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//
import SwiftUI

struct BrailleChartCard: View {
    let item: BrailleChartItem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.gray06)
            .frame(width: 166, height: 132)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray04, lineWidth: 1)
            )
            .overlay {
                HStack(spacing: 26) {
                    Text(item.title)
                        .font(.mainTextBold48)
                        .foregroundStyle(.blue00)
                    BrailleDotsView(pattern: item.braille)
                }
                .padding(.leading, 28)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
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

enum AbbreviationData {
    static let items: [BrailleChartItem] = kor_abbreviations.map { (key, value) in
        
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
    BrailleChartView(category: .jungseong)
        .environment(NavigationCoordinator())
}
