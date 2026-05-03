//
//  CalendarViewModel.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class CalendarViewModel {
    var displayedMonth: Date
    private(set) var entriesByDay: [Date: DailyMoodEntry] = [:]

    private let calendar: Calendar
    @ObservationIgnored private var modelContext: ModelContext?
    @ObservationIgnored private var hasConfigured = false

    init(
        displayedMonth: Date = .now,
        calendar: Calendar = .autoupdatingCurrent
    ) {
        self.calendar = calendar
        self.displayedMonth = calendar.startOfMonth(for: displayedMonth)
    }

    var monthTitle: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }

    var weekdaySymbols: [String] {
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        let firstWeekdayIndex = max(calendar.firstWeekday - 1, 0)
        return Array(symbols[firstWeekdayIndex...] + symbols[..<firstWeekdayIndex])
    }

    var rowCount: Int {
        max(days.count / 7, 1)
    }

    var days: [CalendarDay] {
        let startOfMonth = calendar.startOfMonth(for: displayedMonth)
        let daysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)?.count ?? 0
        let leadingOffset = calendar.leadingWeekdayOffset(for: startOfMonth)
        let trailingOffset = (7 - ((leadingOffset + daysInMonth) % 7)) % 7
        let visibleDayCount = leadingOffset + daysInMonth + trailingOffset

        guard let gridStart = calendar.date(byAdding: .day, value: -leadingOffset, to: startOfMonth) else {
            return []
        }

        return (0..<visibleDayCount).compactMap { index in
            guard let date = calendar.date(byAdding: .day, value: index, to: gridStart) else {
                return nil
            }

            let normalizedDate = calendar.startOfDay(for: date)
            let entry = entriesByDay[normalizedDate]
            return CalendarDay(
                date: normalizedDate,
                isInDisplayedMonth: calendar.isDate(normalizedDate, equalTo: displayedMonth, toGranularity: .month),
                isToday: calendar.isDateInToday(normalizedDate),
                mood: entry?.manualMood ?? entry?.predictedMood
            )
        }
    }

    func configure(modelContext: ModelContext) {
        self.modelContext = modelContext

        guard hasConfigured == false else {
            return
        }

        hasConfigured = true

        do {
            try CalendarMockDataSeeder.seedIfNeeded(using: modelContext, calendar: calendar)
        } catch {
            assertionFailure("Failed to seed calendar mock entries: \(error)")
        }

        reloadDisplayedMonth()
    }

    func reloadDisplayedMonth() {
        guard let modelContext else {
            return
        }

        let monthStart = calendar.startOfMonth(for: displayedMonth)
        guard let monthEnd = calendar.date(byAdding: .month, value: 1, to: monthStart) else {
            return
        }

        do {
            let descriptor = FetchDescriptor<DailyMoodEntry>(
                predicate: #Predicate<DailyMoodEntry> { entry in
                    entry.date >= monthStart && entry.date < monthEnd
                }
            )
            let entries = try modelContext.fetch(descriptor)
            entriesByDay = Dictionary(
                uniqueKeysWithValues: entries.map { (calendar.startOfDay(for: $0.date), $0) }
            )
        } catch {
            entriesByDay = [:]
            assertionFailure("Failed to fetch calendar entries: \(error)")
        }
    }

    func showPreviousMonth() {
        guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) else {
            return
        }

        displayedMonth = calendar.startOfMonth(for: previousMonth)
        reloadDisplayedMonth()
    }

    func showNextMonth() {
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) else {
            return
        }

        displayedMonth = calendar.startOfMonth(for: nextMonth)
        reloadDisplayedMonth()
    }

    func entry(for date: Date) -> DailyMoodEntry? {
        entriesByDay[calendar.startOfDay(for: date)]
    }

    func resetAfterDeleteAllData() {
        entriesByDay = [:]
        reloadDisplayedMonth()
    }
}

private extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components) ?? startOfDay(for: date)
    }

    func leadingWeekdayOffset(for date: Date) -> Int {
        let weekday = component(.weekday, from: date)
        return (weekday - firstWeekday + 7) % 7
    }
}
