//
//  GoalForm.swift
//  Learning Journey App
//
//  الحقل وأزرار المدة، مشتركة بين Onboarding وتعديل الهدف
//
import SwiftUI

struct GoalForm: View {
    @Binding var goal: LearningGoal

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("I want to learn")

            TextField("Swift", text: $goal.topic)
                .padding(.vertical, 12)

            Divider()

            Text("I want to learn it in a")
                .padding(.top, 28)

            HStack(spacing: 12) {
                ForEach(Duration.allCases, id: \.self) { item in
                    Button {
                        goal.duration = item
                    } label: {
                        Text(item.rawValue.capitalized)
                            .foregroundStyle(goal.duration == item ? .white : .gray)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                    .glassEffect(.regular.tint(goal.duration == item ? .orange : nil).interactive())
                }
            }
            .padding(.top, 12)
        }
    }
}
