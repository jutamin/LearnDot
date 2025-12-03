//
//  ChartSelectView.swift
//  LearnDot
//
//  Created by juyeun on 12/2/25.
//

import SwiftUI

struct ChartSelectView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    // MARK: - UI Setting
    var body: some View {
        ZStack {
            Color.black00
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    Text("일람표 선택")
                        .font(.mainTextExtraBold36)
                        .foregroundStyle(.white00)
                        .accessibilityLabel("초성, 중성, 종성, 숫자, 약자, 약어 중 선택해주세요")
                    
                    Spacer()
                }
                .padding(.horizontal, 27)
                
                VStack(spacing: 16) {
                    SelectLearning(
                        title: "초성 일람표"
                    ) {
                        coordinator.push(AppDestination.brailleChartCategory(.choseong))
                    }
                    
                    SelectLearning(
                        title: "중성 일람표"
                    ) {
                        coordinator.push(AppDestination.brailleChartCategory(.jungseong))
                    }
                    
                    SelectLearning(
                        title: "종성 일람표"
                    ) {
                        coordinator.push(AppDestination.brailleChartCategory(.jongseong))
                    }
                  
                    SelectLearning(
                        title: "숫자 일람표"
                    ) {
                        coordinator.push(AppDestination.brailleChartCategory(.number))
                    }
                    
                    SelectLearning(
                        title: "약자 일람표"
                    ) {
                        coordinator.push(AppDestination.brailleChartCategory(.abbreviation))
                    }
                    
                    SelectLearning(
                        title: "약어 일람표"
                    ) {
                        coordinator.push(AppDestination.brailleChartCategory(.contracted))
                    }
                }
                .padding(.top, 30)
                Spacer()
            }
        }
        .ignoresSafeArea()
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
}

#Preview {
    ChartSelectView()
        .environment(NavigationCoordinator())
}
