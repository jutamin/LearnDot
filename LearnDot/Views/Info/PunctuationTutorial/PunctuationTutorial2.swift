//
//  PunctuationTutorial2.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct PunctuationTutorial2: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    @State private var selectedDots: [Bool] = Array(repeating: false, count: 6)
    let indexToDotNumber = [1, 4, 2, 5, 3, 6]
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer().frame(height: 70)
                
                Text("문장부호 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundStyle(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityHidden(true)
                
                Spacer().frame(height: 27)
                
                Group {
                    
                    Text("2. 제시된 문장부호의 점형을 직접 찍어보세요.\n    ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("번호가 붙은 6개의 점이 준비되어 있어요.\n    ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                    + Text("한 번 누르면 해당 번호의 점자가 입력되고,\n    한 번 더 누르면 입력이 취소돼요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 26) {
                        ForEach(0..<6) { index in
                            let dotNumber = indexToDotNumber[index]
                            Button {
                                selectedDots[index].toggle()
                            } label: {
                                Circle()
                                    .fill(selectedDots[index] ? Color.white00 : Color.gray05)
                                    .frame(width: 75, height: 75)
                            }
                            .accessibilityLabel("\(dotNumber)번 점자")
                        }
                    }
                    .padding(.horizontal, 83)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Text("'다음' 버튼을 눌러주세요.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                    .frame(alignment: .leading)
                
                Spacer().frame(height: 24)
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.punctuationTutorial3)
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
    PunctuationTutorial2()
        .environment(NavigationCoordinator())
}
