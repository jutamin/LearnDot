//
//  PunctuationTutorial3.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

struct PunctuationTutorial3: View {
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
                    
                    Text("3. 만약 점자가 더 필요하다면, 6번 점자 다음에\n     나오는 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("'다음점자' 버튼 ")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                    + Text("을 눌러주세요.\n     새로운 점자를 찍을 수 있어요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                
                ZStack{
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
                    
                    Button {} label: {
                        Image(systemName: "chevron.right")
                            .frame(width: 41, height: 70)
                            .foregroundColor(.gray00)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue00, lineWidth: 2)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .accessibilityLabel("다음 점자")
                }
                
                Spacer()
                
                Text("'다음' 버튼을 눌러주세요.")
                    .font(.mainTextSemiBold15)
                    .foregroundStyle(.gray02)
                    .frame(alignment: .leading)
                
                Spacer().frame(height: 24)
                
                HStack {
                    Spacer()
                    
                    Button {
                        coordinator.push(AppDestination.punctuationTutorial4)
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
    PunctuationTutorial3()
        .environment(NavigationCoordinator())
}
