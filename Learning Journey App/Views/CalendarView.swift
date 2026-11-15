//
//  CalendarView.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
import SwiftUI

struct CalendarView: View {
    @Environment(LearningState.self) private var learningState
    @State private var viewModel = CalendarViewModel()

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.months(from: learningState.firstLoggedDate), id: \.self) { month in

                    Text(month.formatted(.dateTime.month(.wide).year()))
                        .font(.headline)

                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
                            Text(symbol).font(.caption).foregroundStyle(.gray)
                        }

                        ForEach(Array(viewModel.days(in: month).enumerated()), id: \.offset) { _, date in
                            if let date {
                                Text(date.formatted(.dateTime.day()))
                                    .foregroundStyle(color(for: learningState.status(for: date)))
                            } else {
                                Text("")
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Activities")
    }

    private func color(for status: Status) -> Color {
        switch status {
        case .learned:   .orange
        case .freezed:   .cyan
        case .notLogged: .white
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
