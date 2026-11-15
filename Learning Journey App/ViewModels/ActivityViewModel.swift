//
//  ActivityViewModel.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import Foundation
import Observation

@Observable
class ActivityViewModel {

    // "1 day" مو "1 days"
    func dayText(_ count: Int) -> String {
        count == 1 ? "1 day" : "\(count) days"
    }

    func freezesUsedText(used: Int, max: Int) -> String {
        "\(used) out of \(max) Freezes used"
    }

    func logButtonTitle(for status: Status) -> String {
        switch status {
        case .learned:   "Logged as Learned"
        case .freezed:   "Day Freezed"
        case .notLogged: "Log as Learned"
        }
    }

    func freezeButtonTitle(for status: Status) -> String {
        status == .freezed ? "Freezed for a day" : "Freeze for a day"
    }

    // أيام الأسبوع الحالي من الأحد للسبت
    var currentWeek: [Date] {
        let calendar = Calendar.current
        guard let week = calendar.dateInterval(of: .weekOfYear, for: .now) else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: week.start) }
    }
}
