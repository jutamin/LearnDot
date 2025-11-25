//
//  OnboardingView.swift
//  LearnDot
//
//  Created by 원주연 on 6/13/25.
//

import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case manual0 = 0
    case manual1 = 1
    case manual2 = 2
    case manual3 = 3
    case manual4 = 4
}

struct OnboardingView: View {
    @State private var currentStep: OnboardingStep = .manual0
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        ZStack {
            Color.black00
                .ignoresSafeArea()
            
            switch currentStep {
            case .manual0:
                OnboardingManual0(onNext: { nextStep() })
            case .manual1:
                OnboardingManual1(onNext: { nextStep() },
                                  onBack: { previousStep() })
            case .manual2:
                OnboardingManual2(onNext: { nextStep() },
                                  onBack: { previousStep() })
            case .manual3:
                OnboardingManual3(onNext: { nextStep() },
                                  onBack: { previousStep() })
            case .manual4:
                OnboardingManual4(onNext: { finishOnboarding() },
                                    onBack: { previousStep() })
            }
        }
    }
    
    private func nextStep() {
        if let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) {
            currentStep = nextStep
        }
    }
    
    private func previousStep() {
            if let prevStep = OnboardingStep(rawValue: currentStep.rawValue - 1) {
                currentStep = prevStep
            }
        }
    
    private func finishOnboarding() {
        isFirstLaunching = false
    }
}
