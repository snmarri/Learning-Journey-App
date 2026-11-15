import SwiftUI

@main
struct LearningJourneyApp: App {
    @State private var learningState = LearningState()

    var body: some Scene {
        WindowGroup {
            Group {
                if learningState.hasGoal {
                    NavigationStack {
                        ActivityView()
                    }
                } else {
                    OnboardingView()
                }
            }
            .environment(learningState)
        }
    }
}
