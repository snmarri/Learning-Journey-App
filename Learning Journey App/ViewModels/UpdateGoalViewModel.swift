//
//  UpdateGoalViewModel.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import Foundation
import Observation

@Observable
class UpdateGoalViewModel {
    var goal: LearningGoal

    init(currentGoal: LearningGoal) {
        goal = currentGoal
    }

    var canSave: Bool {
        goal.isValid
    }
}
