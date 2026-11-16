//
//  DayCircle.swift
//  Learning Journey App
//
//  دائرة اليوم، مشتركة بين شريط الأسبوع في Activity والتقويم
//
import SwiftUI

struct DayCircle: View {
    let date: Date
    let status: Status

    var body: some View {
        Text(date.formatted(.dateTime.day()))
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(textColor)
            .frame(width: 44, height: 44)
            .background(backgroundColor, in: .circle)
    }

    // LearningState يقول وش حالة اليوم، والـ View يقرر وش لونها
    private var textColor: Color {
        switch status {
        case .learned:   .orange
        case .freezed:   .cyan
        case .notLogged: .white
        }
    }

    private var backgroundColor: Color {
        switch status {
        case .learned:   .orange.opacity(0.2)
        case .freezed:   .cyan.opacity(0.2)
        case .notLogged: Calendar.current.isDateInToday(date) ? .orange : .clear
        }
    }
}
