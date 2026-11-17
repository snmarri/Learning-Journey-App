//
//  LearningState.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import Foundation
import Observation

@Observable
class LearningState {

    // MARK: - Storage keys (private: محد يحفظ إلا LearningState)

    private enum Keys {
        static let topic          = "topic"
        static let duration       = "duration"
        static let learnedCount   = "learnedCount"
        static let freezedCount   = "freezedCount"
        static let lastLoggedDate = "lastLoggedDate"
        static let dayHistory     = "dayHistory"
        static let didMissGoal    = "didMissGoal"
    }

    // MARK: - 1. Saved data

    var goal: LearningGoal
    var learnedCount: Int
    var freezedCount: Int
    var lastLoggedDate: Date?
    var dayHistory: [String: String]
    var didMissGoal: Bool

    init() {
        let saved = UserDefaults.standard

        let topic = saved.string(forKey: Keys.topic) ?? ""
        let durationText = saved.string(forKey: Keys.duration) ?? ""
        let duration = Duration(rawValue: durationText) ?? .week

        goal           = LearningGoal(topic: topic, duration: duration)
        learnedCount   = saved.integer(forKey: Keys.learnedCount)
        freezedCount   = saved.integer(forKey: Keys.freezedCount)
        lastLoggedDate = saved.object(forKey: Keys.lastLoggedDate) as? Date
        dayHistory     = saved.dictionary(forKey: Keys.dayHistory) as? [String: String] ?? [:]
        didMissGoal    = saved.bool(forKey: Keys.didMissGoal)

        checkStreak()
    }

    // MARK: - 2. Computed

    var hasGoal: Bool {
        goal.isValid
    }

    var freezesLeft: Int {
        goal.duration.maxFreezes - freezedCount
    }

    var isLoggedToday: Bool {
        guard let lastLoggedDate else { return false }
        return Calendar.current.isDateInToday(lastLoggedDate)
    }

    var isGoalCompleted: Bool {
        learnedCount + freezedCount >= goal.duration.days
    }

    var canLog: Bool {
        !isLoggedToday && !isGoalCompleted && !didMissGoal
    }

    var canFreeze: Bool {
        canLog && freezesLeft > 0
    }

    // MARK: - 3. Actions

    func setGoal(_ newGoal: LearningGoal) {
        goal = newGoal
        learnedCount = 0
        freezedCount = 0
        lastLoggedDate = nil
        didMissGoal = false
        save()
    }

    func logAsLearned() {
        guard canLog else { return }
        learnedCount += 1
        recordToday(as: .learned)
    }

    func freezeDay() {
        guard canFreeze else { return }
        freezedCount += 1
        recordToday(as: .freezed)
    }

    private func recordToday(as status: Status) {
        lastLoggedDate = .now
        dayHistory[key(for: .now)] = status.rawValue
        save()
    }

    // MARK: - 4. Rules

    func checkStreak() {
        guard let lastLoggedDate, !didMissGoal, !isGoalCompleted else { return }
        let limit: TimeInterval = 32 * 60 * 60

        if Date.now.timeIntervalSince(lastLoggedDate) > limit {
            didMissGoal = true
            save()
        }
    }

    // MARK: - 5. Day status

    func status(for date: Date) -> Status {
        Status(rawValue: dayHistory[key(for: date)] ?? "") ?? .notLogged
    }

    private func key(for date: Date) -> String {
        Self.dayFormatter.string(from: date)
    }
    var firstLoggedDate: Date? {
        dayHistory.keys
            .compactMap { Self.dayFormatter.date(from: $0) }
            .min()
    }
    
    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // MARK: - 6. Save

    private func save() {
        let defaults = UserDefaults.standard
        defaults.set(goal.topic, forKey: Keys.topic)
        defaults.set(goal.duration.rawValue, forKey: Keys.duration)
        defaults.set(learnedCount, forKey: Keys.learnedCount)
        defaults.set(freezedCount, forKey: Keys.freezedCount)
        defaults.set(lastLoggedDate, forKey: Keys.lastLoggedDate)
        defaults.set(dayHistory, forKey: Keys.dayHistory)
        defaults.set(didMissGoal, forKey: Keys.didMissGoal)
    }
}
