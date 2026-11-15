//
//  ActivityView.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import SwiftUI

struct ActivityView: View {
    @Environment(LearningState.self) private var learningState
    @State private var viewModel = ActivityViewModel()

    var body: some View {
        VStack(spacing: 20) {

            Text("\(learningState.goal.topic) · \(learningState.goal.duration.rawValue)")
                .font(.title)

            // Week
            HStack {
                ForEach(viewModel.currentWeek, id: \.self) { date in
                    VStack {
                        Text(date.formatted(.dateTime.day()))
                        Text(learningState.status(for: date).rawValue)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }

            // Counts
            Text("Learned: \(viewModel.dayText(learningState.learnedCount))")
            Text("Freezed: \(viewModel.dayText(learningState.freezedCount))")

            // Goal ended
            if learningState.isGoalCompleted {
                Text("Well done!").foregroundStyle(.orange)
            } else if learningState.didMissGoal {
                Text("You didn't reach your goal").foregroundStyle(.red)
            }

            // Buttons
            Button(viewModel.logButtonTitle(for: learningState.status(for: .now))) {
                learningState.logAsLearned()
            }
            .disabled(!learningState.canLog)

            Button(viewModel.freezeButtonTitle(for: learningState.status(for: .now))) {
                learningState.freezeDay()
            }
            .disabled(!learningState.canFreeze)

            Text(viewModel.freezesUsedText(used: learningState.freezedCount,
                                           max: learningState.goal.duration.maxFreezes))
                .foregroundStyle(.gray)

            // للتجربة بس، بنحذفه بعدين
            NavigationLink("Edit goal") {
                UpdateGoalView(currentGoal: learningState.goal)
            }
            NavigationLink("Calendar") {
                CalendarView()
            }
            Button("Test: start over") {
                learningState.setGoal(LearningGoal(topic: "", duration: .week))
            }
            .foregroundStyle(.red)
        }
        .padding()
        .onAppear {
            learningState.checkStreak()
        }
    }
}

#Preview {
    ActivityView()
        .environment(LearningState())
        .preferredColorScheme(.dark)
}
