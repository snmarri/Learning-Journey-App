//
//  CalendarViewModel.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import Foundation
import Observation

@Observable
class CalendarViewModel {
    private let calendar = Calendar.current

    // كل الشهور من أول يوم مسجّل لين الشهر الحالي
    func months(from firstDate: Date?) -> [Date] {
        guard let start = calendar.dateInterval(of: .month, for: firstDate ?? .now)?.start,
              let end = calendar.dateInterval(of: .month, for: .now)?.start else { return [] }

        var result: [Date] = []
        var month = start

        while month <= end {
            result.append(month)
            guard let next = calendar.date(byAdding: .month, value: 1, to: month) else { break }
            month = next
        }
        return result
    }

    // أيام الشهر، و nil للخانات الفاضية قبل أول يوم
    func days(in month: Date) -> [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }

        let firstWeekday = calendar.component(.weekday, from: month)
        let emptySlots = (firstWeekday - calendar.firstWeekday + 7) % 7

        let dates = range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: month)
        }
        return Array(repeating: nil, count: emptySlots) + dates
    }

    // SUN MON TUE ...
    var weekdaySymbols: [String] {
        let symbols = calendar.shortWeekdaySymbols.map { $0.uppercased() }
        let first = calendar.firstWeekday - 1
        return Array(symbols[first...] + symbols[..<first])
    }
}
