//
//  UpdateGoalView.swift
//  Learning Journey App
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
        VStack {
            GoalForm(goal: $viewModel.goal)
                .padding(.top, 24)

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle("Learning Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
                .tint(.orange)
                .disabled(!viewModel.canSave)
            }
        }
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
    NavigationStack {
        UpdateGoalView(currentGoal: LearningGoal(topic: "Swift", duration: .week))
    }
    .environment(LearningState())
    .preferredColorScheme(.dark)
}
