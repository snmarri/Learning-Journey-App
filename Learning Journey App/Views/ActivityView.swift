//
//  ActivityView.swift
//  Learning Journey App
//
import SwiftUI

struct ActivityView: View {
    @Environment(LearningState.self) private var learningState
    @State private var viewModel = ActivityViewModel()

    var body: some View {
        VStack(spacing: 24) {
            header
            weekStrip
            statCards

            Spacer()

            if learningState.isGoalCompleted {
                goalEnded(icon: "hands.clap.fill",
                          title: "Well done!",
                          subtitle: "Ready for your next goal?")
                Spacer()
            } else if learningState.didMissGoal {
                goalEnded(icon: "xmark.seal",
                          title: "You didn't reach your goal this time.",
                          subtitle: "Want to set another goal?")
                Spacer()
            } else {
                logButton
                Spacer()
                freezeSection
            }
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            learningState.checkStreak()
        }
    }

    // MARK: - 1. Header

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Activity")
                    .font(.largeTitle.bold())

                Text(Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide)))
                    .foregroundStyle(.gray)
            }

            Spacer()

            NavigationLink {
                CalendarView()
            } label: {
                headerIcon("calendar")
            }

            NavigationLink {
                UpdateGoalView(currentGoal: learningState.goal)
            } label: {
                headerIcon("pencil.and.outline")
            }
        }
        .buttonStyle(.plain)
    }

    private func headerIcon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.title3)
            .frame(width: 44, height: 44)
            .glassEffect(.regular.interactive(), in: .circle)
    }

    // MARK: - 2. Week strip

    private var weekStrip: some View {
        HStack {
            ForEach(viewModel.currentWeek, id: \.self) { date in
                VStack(spacing: 4) {
                    Text(date.formatted(.dateTime.weekday(.narrow)))
                        .font(.footnote.weight(.semibold))

                    DayCircle(date: date, status: learningState.status(for: date))
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - 3. Stat cards

    private var statCards: some View {
        HStack(spacing: 12) {
            statCard(icon: "flame.fill", color: .orange,
                     value: viewModel.dayText(learningState.learnedCount), label: "Learned")
            statCard(icon: "snowflake", color: .cyan,
                     value: viewModel.dayText(learningState.freezedCount), label: "Freezed")
        }
    }

    private func statCard(icon: String, color: Color, value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundStyle(color)

            Text(value)
                .font(.headline)

            Text(label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .glassEffect(.regular, in: .rect(cornerRadius: 34))
    }

    // MARK: - 4. Log button

    private var logButton: some View {
        Button {
            learningState.logAsLearned()
        } label: {
            Text(viewModel.logButtonTitle(for: learningState.status(for: .now)))
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(learningState.canLog ? .white : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(learningState.canLog ? .orange : nil).interactive(), in: .circle)
        .disabled(!learningState.canLog)
        .padding(.horizontal, 44)
    }

    // MARK: - 5. Freeze

    private var freezeSection: some View {
        VStack(spacing: 16) {
            Button {
                learningState.freezeDay()
            } label: {
                Text(viewModel.freezeButtonTitle(for: learningState.status(for: .now)))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.glassProminent)
            .tint(.cyan)
            .disabled(!learningState.canFreeze)
            .padding(.horizontal, 44)

            Text(viewModel.freezesUsedText(used: learningState.freezedCount,
                                           max: learningState.goal.duration.maxFreezes))
                .font(.footnote)
                .foregroundStyle(.gray)
        }
    }

    // MARK: - Goal ended (Well done / Didn't reach)

    private func goalEnded(icon: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(.orange)

            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.gray)

            NavigationLink {
                UpdateGoalView(currentGoal: learningState.goal)
            } label: {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.glassProminent)
            .tint(.orange)
            .padding(.top, 40)
        }
    }
}

#Preview {
    NavigationStack {
        ActivityView()
    }
    .environment(LearningState())
    .preferredColorScheme(.dark)
}
