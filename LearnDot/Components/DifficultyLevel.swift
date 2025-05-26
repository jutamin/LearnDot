//
//  DifficultyLevel.swift
//  LearnDot
//
//  Created by 신혜연 on 5/26/25.
//

import Foundation

enum DifficultyLevel {
    case easy
    case normal
    case hard
}

enum WordCategory: String, CaseIterable, Identifiable {
    case food = "음식/식료품"
    case restroom = "화장실 표시/건물 안내"
    case transport = "지하철/버스"
    case medicine = "의약품/약국"
    case electronics = "가전제품 조작"

    var id: String { rawValue }

    func description(for level: DifficultyLevel) -> String {
        switch self {
        case .food:
            switch level {
            case .easy: return "과일 이름" // 사과, 포도, 귤, 딸기
            case .normal: return "음식 종류" // 중식, 일식, 한식
            case .hard: return "카페 인기 음료" // 아메리카노, 카페라떼
            }
        case .restroom:
            switch level {
            case .easy: return "남자/여자 화장실" // 남자, 여자, 화장실, 유아용, 수유실
            case .normal: return "화장실 내 시설" // 세면대, 휴지통, 자동문
            case .hard: return "상세 지원 도구" // 장애인 호출 버튼, 잠금 장치
            }
        case .transport:
            switch level {
            case .easy: return "지역 이름" // 서울, 경기, 대전, 대구, 부산
            case .normal: return "지하철 역 이름" // 서울역, 공릉역
            case .hard: return "안내 방송" // 출입문, 종착역, 승강장안내, 하차
            }
        case .medicine:
            switch level {
            case .easy: return "기본 약 이름" // 약, 감기약, 두통약
            case .normal: return "복용 방법" // 식후복용, 하루2번
            case .hard: return "복잡한 약 정보" // 복약안내, 사용설명서, 약사상담
            }
        case .electronics:
            switch level {
            case .easy: return "전원/볼륨 버튼" // 전원, 볼륨, 재생
            case .normal: return "기능 버튼 설명" // 설정, 메뉴, 저장
            case .hard: return "기기 설정 용어" // 무선연결, 접근성, 초기화설정
            }
        }
    }
}
