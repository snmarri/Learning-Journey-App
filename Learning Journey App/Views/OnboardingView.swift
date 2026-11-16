import SwiftUI

struct OnboardingView: View {
    @Environment(LearningState.self) private var learningState
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // 1. Icon
            Image(systemName: "flame.fill")
                .font(.system(size: 40))
                .foregroundStyle(.orange)
                .frame(maxWidth: .infinity)
                .padding(.top, 56)

            // 2. Welcome
            Text("Hello \(Text("Learner").bold())")
                .font(.largeTitle)
                .padding(.top, 80)

            Text("This app will help you learn everyday!")
                .foregroundStyle(.gray)
                .padding(.top, 4)

            // 3. Goal
            GoalForm(goal: $viewModel.goal)
                .padding(.top, 36)

            Spacer()

            // 4. Start
            VStack(spacing: 12) {
                Button {
                    learningState.setGoal(viewModel.goal)
                } label: {
                    Text("Start Learning")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.glassProminent)
                .tint(.orange)
                .disabled(!viewModel.canStart)

                Text("You can edit your desire later")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    OnboardingView()
        .environment(LearningState())
        .preferredColorScheme(.dark)
}
