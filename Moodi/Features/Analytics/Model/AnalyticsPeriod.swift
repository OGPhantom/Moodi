//
//  AnalyticsPeriod.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation

enum AnalyticsPeriod: String, CaseIterable, Identifiable {
    case week
    case month
    case year
    case allTime

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .week:
            "Week"
        case .month:
            "Month"
        case .year:
            "Year"
        case .allTime:
            "All Time"
        }
    }

    func dateInterval(
        relativeTo today: Date,
        entries: [DailyMoodEntry],
        calendar: Calendar = .autoupdatingCurrent
    ) -> DateInterval? {
        let end = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: today)) ?? today

        switch self {
        case .week:
            guard let start = calendar.date(byAdding: .day, value: -7, to: end) else {
                return nil
            }

            return DateInterval(start: start, end: end)
        case .month:
            guard let start = calendar.date(byAdding: .day, value: -30, to: end) else {
                return nil
            }

            return DateInterval(start: start, end: end)
        case .year:
            guard let start = calendar.date(byAdding: .day, value: -365, to: end) else {
                return nil
            }

            return DateInterval(start: start, end: end)
        case .allTime:
            guard let firstEntryDate = entries.map(\.date).min() else {
                return nil
            }

            return DateInterval(start: calendar.startOfDay(for: firstEntryDate), end: end)
        }
    }
}
