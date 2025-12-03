//
//  BrailleChartView.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//

import SwiftUI

struct BrailleChartView: View {
    let category: BrailleChartCategory
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        Color.black00
            .ignoresSafeArea()
            .overlay{
                ScrollView {
                    let columns = [
                        GridItem(.flexible(), spacing: 0),
                        GridItem(.flexible(), spacing: 0)
                    ]
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(items(for: category)) { item in
                            BrailleChartCard(item: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(title(for: category))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coordinator.popToRoot()
                    } label: {
                        Text("홈으로")
                            .foregroundColor(.white00)
                            .font(.mainTextSemiBold18)
                    }
                }
            }
    }
    
    private func title(for category: BrailleChartCategory) -> String {
        switch category {
        case .choseong: return "초성 일람표"
        case .jungseong: return "중성 일람표"
        case .jongseong: return "종성 일람표"
        case .number: return "숫자 일람표"
        case .abbreviation: return "약자 일람표"
        case .contracted: return "약어 일람표"
        }
    }
    
    private func items(for category: BrailleChartCategory) -> [BrailleChartItem] {
        switch category {
        case .choseong:
            return ChoseongData.items
        case .jungseong:
            return JungseongData.items
        case .jongseong:
            return JongseongData.items
        case .number:
            return NumberData.items
        case .abbreviation:
            return AbbreviationData.items
        case .contracted:
            return contractedData.items
        }
    }
}
#Preview {
    BrailleChartView(category: .abbreviation)
        .environment(NavigationCoordinator())
}
