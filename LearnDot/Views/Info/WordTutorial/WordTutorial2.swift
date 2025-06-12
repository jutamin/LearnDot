//
//  WordTutorial2.swift
//  LearnDot
//
//  Created by 원주연 on 6/12/25.
//

import SwiftUI

struct WordTutorial2: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer().frame(height: 70)
                
                Text("난이도별 점형 학습 안내")
                    .font(.mainTextBold32)
                    .foregroundStyle(.white00)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityHidden(true)
                
                Spacer().frame(height: 27)
                
                Group {
                    
                    Text("2. 단어 카테고리 5개가 주어져요.\n")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                    + Text("(식품/화장실/철도/의약품/가전제품)\n")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.blue00)
                        .accessibilityLabel("식품, 화장실, 철도, 의약품, 가전제품")
                    + Text("관심있는 주제를 선택해주세요.")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white00)
                }
                
                Spacer()
                
                VStack(spacing: 6) {
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 192, height: 58)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("음식/식료품")
                                        .font(.mainTextSemiBold15)
                                        .foregroundStyle(.blue00)
                                        .accessibilityLabel("음식")
                                    
                                    Text("과일 이름")
                                        .font(.mainTextMedium10)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 192, height: 58)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("화장실 표시/건물 안내")
                                        .font(.mainTextSemiBold15)
                                        .foregroundStyle(.blue00)
                                        .accessibilityLabel("화장실 안내")
                                    
                                    Text("공공화장실 용어")
                                        .font(.mainTextMedium10)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 192, height: 58)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("지하철/버스")
                                        .font(.mainTextSemiBold15)
                                        .foregroundStyle(.blue00)
                                        .accessibilityLabel("철도")
                                    
                                    Text("지역 이름")
                                        .font(.mainTextMedium10)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 192, height: 58)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("의약품/약국")
                                        .font(.mainTextSemiBold15)
                                        .foregroundStyle(.blue00)
                                        .accessibilityLabel("의약품")
                                    
                                    Text("기본 약 이름")
                                        .font(.mainTextMedium10)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray06)
                            .frame(width: 192, height: 58)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray04, lineWidth: 1)
                            )
                            .overlay {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("가전제품 조작")
                                        .font(.mainTextSemiBold15)
                                        .foregroundStyle(.blue00)
                                        .accessibilityLabel("가전제품")
                                    
                                    Text("전원,볼륨버튼")
                                        .font(.mainTextMedium10)
                                        .foregroundStyle(.gray01)
                                }
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                    }
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
                        coordinator.push(AppDestination.wordTutorial3)
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
    WordTutorial2()
        .environment(NavigationCoordinator())
}
