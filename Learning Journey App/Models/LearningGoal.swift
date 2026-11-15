//
//  LearningGoal.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import Foundation

struct LearningGoal {
    var topic: String
    var duration: Duration

    var isValid: Bool {
        !topic.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
