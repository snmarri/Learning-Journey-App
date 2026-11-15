//
//  OnboardingViewModel.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import Foundation
import Observation

@Observable
class OnboardingViewModel {
    var goal = LearningGoal(topic: "", duration: .week)

    var canStart: Bool {
        goal.isValid
    }
}
