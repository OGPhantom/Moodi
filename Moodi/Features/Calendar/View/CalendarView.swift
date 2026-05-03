//
//  CalendarView.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI
import SwiftData

@MainActor
struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var model = CalendarViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: MoodiUI.sectionSpacing) {
                    CalendarMonthHeader(
                        monthTitle: model.monthTitle,
                        previousAction: showPreviousMonth,
                        nextAction: showNextMonth
                    )

                    CalendarGridCard(
                        weekdaySymbols: model.weekdaySymbols,
                        days: model.days,
                        rowCount: model.rowCount,
                        entryProvider: model.entry(for:)
                    )
                    .frame(maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, MoodiUI.screenPadding)
                .padding(.top, MoodiUI.topSpacing)
                .padding(.bottom, MoodiUI.bottomSpacing)
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                AppBackground()
            }
            .task {
                model.configure(modelContext: modelContext)
            }
            .onAppear {
                model.reloadDisplayedMonth()
            }
            .onReceive(NotificationCenter.default.publisher(for: .moodiDidDeleteAllData)) { _ in
                model.resetAfterDeleteAllData()
            }
        }
    }

    private func showPreviousMonth() {
        withAnimation(.snappy(duration: 0.28, extraBounce: 0.02)) {
            model.showPreviousMonth()
        }
    }

    private func showNextMonth() {
        withAnimation(.snappy(duration: 0.28, extraBounce: 0.02)) {
            model.showNextMonth()
        }
    }
}

#Preview {
    CalendarView()
        .modelContainer(for: DailyMoodEntry.self, inMemory: true)
}
