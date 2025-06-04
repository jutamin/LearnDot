//
//  PunctuationQuizView.swift
//  LearnDot
//
//  Created by 신혜연 on 6/3/25.
//

import SwiftUI

struct PunctuationQuizView: View {
    
    @State private var selectedDots: Set<Int> = []
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("다음 문장부호의 점자를 찍어보세요.")
                    .font(.mainTextBold24)
                    .foregroundStyle(.blue00)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray06)
                    .frame(width: 240, height: 72)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .overlay {
                        Text(". 온점")
                            .font(.mainTextSemiBold24)
                            .foregroundStyle(.white00)
                    }
                    .padding(.top, 12)
                
                ZStack {
                    HStack(spacing: 26) {
                        Button {
                            // 왼쪽 버튼 동작
                        } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 41, height: 70)
                                .foregroundColor(.gray00)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.blue00, lineWidth: 2)
                                )
                        }
                        
                        Spacer()
                        
                        Button {
                            // 오른쪽 버튼 동작
                        } label: {
                            Image(systemName: "chevron.right")
                                .frame(width: 41, height: 70)
                                .foregroundColor(.gray00)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.blue00, lineWidth: 2)
                                )
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 26) {
                        ForEach(0..<6) { index in
                            Circle()
                                .fill(selectedDots.contains(index) ? Color.white00 : Color.gray05)
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    if selectedDots.contains(index) {
                                        selectedDots.remove(index)
                                    } else {
                                        selectedDots.insert(index)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 83)
                }
                .padding(.top, 42)
                
                HStack(spacing: 17) {
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray01)
                            .frame(width: 168, height: 64)
                            .overlay {
                                Text("다시쓰기")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.black00)
                            }
                    }
                    
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue01)
                            .frame(width: 168, height: 64)
                            .overlay {
                                Text("작성완료")
                                    .font(.mainTextBold24)
                                    .foregroundStyle(.white00)
                            }
                    }
                }
                .padding(.top, 46)
            }
        }
    }
}

#Preview {
    PunctuationQuizView()
}
