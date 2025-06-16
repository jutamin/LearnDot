//
//  FontManager.swift
//  LearnDot
//
//  Created by 원주연 on 5/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // ExtraBold
    
    static var mainTextExtraBold70: Font {
        return .pretend(type: .extraBold, size: 70)
    }
    
    static var mainTextExtraBold60: Font {
        return .pretend(type: .extraBold, size: 60)
    }
    
    static var mainTextExtraBold50: Font {
        return .pretend(type: .extraBold, size: 50)
    }
    
    static var mainTextExtraBold45: Font {
        return .pretend(type: .extraBold, size: 45)
    }
    
    static var mainTextExtraBold36: Font {
        return .pretend(type: .extraBold, size: 36)
    }
    
    // Bold
    static var mainTextBold30: Font {
        return .pretend(type: .bold, size: 30)
    }
    
    static var mainTextBold32: Font {
        return .pretend(type: .bold, size: 32)
    }
    
    static var mainTextBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    // SemiBold
    static var mainTextSemiBold32: Font {
        return .pretend(type: .semibold, size: 32)
    }
    
    static var mainTextSemiBold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var mainTextSemiBold20: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var mainTextSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    static var mainTextSemiBold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    
    static var mainTextSemiBold15: Font {
        return .pretend(type: .semibold, size: 15)
    }
    
    static var mainTextSemiBold13: Font {
        return .pretend(type: .semibold, size: 13)
    }
    
    static var mainTextSemiBold12: Font {
        return .pretend(type: .semibold, size: 12)
    }
    
    // Medium
    static var mainTextMedium10: Font {
        return .pretend(type: .medium, size: 10)
    }
    
    static var mainTextMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
}
