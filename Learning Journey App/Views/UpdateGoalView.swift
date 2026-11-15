//
//  UpdateGoalView.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import SwiftUI

struct UpdateGoalView: View {
    @Environment(LearningState.self) private var learningState
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: UpdateGoalViewModel
    @State private var showAlert = false

    init(currentGoal: LearningGoal) {
        _viewModel = State(initialValue: UpdateGoalViewModel(currentGoal: currentGoal))
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Swift", text: $viewModel.goal.topic)

            HStack {
                ForEach(Duration.allCases, id: \.self) { item in
                    Button(item.rawValue.capitalized) {
                        viewModel.goal.duration = item
                    }
                    .foregroundStyle(viewModel.goal.duration == item ? .orange : .gray)
                }
            }

            Button("Save") {
                showAlert = true
            }
            .disabled(!viewModel.canSave)

            Spacer()
        }
        .padding()
        .alert("Update goal", isPresented: $showAlert) {
            Button("Dismiss", role: .cancel) { }
            Button("Update") {
                learningState.setGoal(viewModel.goal)
                dismiss()
            }
        } message: {
            Text("If you update now, your streak will start over.")
        }
    }
}

#Preview {
    UpdateGoalView(currentGoal: LearningGoal(topic: "Swift", duration: .week))
        .environment(LearningState())
        .preferredColorScheme(.dark)
}
