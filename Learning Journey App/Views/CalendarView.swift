//
//  CalendarView.swift
//  Learning Journey App
//
//  للعرض بس، ما فيه ضغط على الأيام
//
import SwiftUI

struct CalendarView: View {
    @Environment(LearningState.self) private var learningState
    @State private var viewModel = CalendarViewModel()

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.months(from: learningState.firstLoggedDate), id: \.self) { month in
                    monthSection(month)
                    Divider()
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func monthSection(_ month: Date) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(month.formatted(.dateTime.month(.wide).year()))
                .font(.headline)

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.gray)
                }

                ForEach(Array(viewModel.days(in: month).enumerated()), id: \.offset) { _, date in
                    if let date {
                        DayCircle(date: date, status: learningState.status(for: date))
                    } else {
                        Color.clear.frame(height: 44)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
    .environment(LearningState())
    .preferredColorScheme(.dark)
}
