import SwiftUI

struct OnboardingView: View {
    @State private var viewModel = OnboardingViewModel()
    @Environment(LearningState.self) private var learningState
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
            Text("I want to learn")
                .padding(.top, 36)

            TextField("Swift", text: $viewModel.goal.topic)
                .padding(.vertical, 12)

            Divider()

            Text("I want to learn it in a")
                .padding(.top, 28)

            HStack(spacing: 12) {
                ForEach(Duration.allCases, id: \.self) { item in
                    Button {
                        viewModel.goal.duration = item
                    } label: {
                        Text(item.rawValue.capitalized)
                            .foregroundStyle(viewModel.goal.duration == item ? .white : .gray)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                    .glassEffect(.regular.tint(viewModel.goal.duration == item ? .orange : nil).interactive())
                }
            }
            .padding(.top, 12)                          
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
