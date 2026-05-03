//
//  AnalyticsViewModel.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class AnalyticsViewModel {
    var selectedPeriod: AnalyticsPeriod = .month
    var selectedMetric: TodayMetricKind = .sleep

    private let calendar = Calendar.autoupdatingCurrent

    func shouldShowEmptyState(for entries: [DailyMoodEntry]) -> Bool {
        filteredEntries(from: entries).isEmpty
    }

    func emptyStateTitle(for entries: [DailyMoodEntry]) -> String {
        hasStoredEntries(entries) ? "No data in this period" : "Analytics is waiting for your first entries"
    }

    func emptyStateMessage(for entries: [DailyMoodEntry]) -> String {
        if hasStoredEntries(entries) {
            return "Try a longer range or keep logging daily metrics to reveal patterns over time."
        }

        return "Log a few days of mood and behavior data to unlock trend summaries and charts."
    }

    func summary(from entries: [DailyMoodEntry]) -> AnalyticsSummary {
        let filteredEntries = filteredEntries(from: entries)
        let moods = filteredEntries.compactMap(\.effectiveMood)

        let dominantMood = dominantMoodAndShare(from: filteredEntries)

        return AnalyticsSummary(
            dominantMood: dominantMood?.mood,
            dominantMoodShare: dominantMood?.share,
            averageSleep: average(filteredEntries.compactMap(\.sleepHours)),
            averageActivity: average(filteredEntries.compactMap(\.activityMinutes)),
            averageScreenTime: average(filteredEntries.compactMap(\.screenTimeHours)),
            averageSteps: average(filteredEntries.compactMap(\.steps)),
            loggedDayCount: moods.isEmpty ? filteredEntries.count : moods.count
        )
    }

    func filteredEntries(from entries: [DailyMoodEntry]) -> [DailyMoodEntry] {
        let storedEntries = entries
            .filter(\.hasAnyData)
            .sorted { $0.date < $1.date }

        guard let interval = selectedPeriod.dateInterval(relativeTo: .now, entries: storedEntries, calendar: calendar) else {
            return []
        }

        return storedEntries.filter { interval.contains($0.date) }
    }

    func moodTimelinePoints(from entries: [DailyMoodEntry]) -> [AnalyticsMoodTimelinePoint] {
        let filteredEntries = filteredEntries(from: entries)
        guard
            let interval = selectedPeriod.dateInterval(relativeTo: .now, entries: entries.filter(\.hasAnyData), calendar: calendar),
            filteredEntries.isEmpty == false
        else {
            return []
        }

        let moodsByDay = filteredEntries.reduce(into: [Date: TodayMood?]()) { partialResult, entry in
            partialResult[calendar.startOfDay(for: entry.date)] = entry.effectiveMood
        }

        return dates(in: interval).map { day in
            AnalyticsMoodTimelinePoint(date: day, mood: moodsByDay[day] ?? nil)
        }
    }

    func metricTrendPoints(from entries: [DailyMoodEntry]) -> [AnalyticsMetricTrendPoint] {
        filteredEntries(from: entries).compactMap { entry in
            guard let value = entry.value(for: selectedMetric) else {
                return nil
            }

            return AnalyticsMetricTrendPoint(
                date: calendar.startOfDay(for: entry.date),
                value: value
            )
        }
    }

    func percentText(for share: Double?) -> String {
        guard let share else {
            return "--"
        }

        return "\(Int((share * 100).rounded()))% of logged days"
    }

    func hasStoredEntries(_ entries: [DailyMoodEntry]) -> Bool {
        entries.contains(where: \.hasAnyData)
    }

    private func dominantMoodAndShare(from entries: [DailyMoodEntry]) -> (mood: TodayMood, share: Double)? {
        let moodEntries = entries.compactMap { entry -> (Date, TodayMood)? in
            guard let mood = entry.effectiveMood else {
                return nil
            }

            return (entry.date, mood)
        }

        guard moodEntries.isEmpty == false else {
            return nil
        }

        let grouped = Dictionary(grouping: moodEntries, by: { $0.1 })

        guard let dominantMood = grouped.max(by: { lhs, rhs in
            if lhs.value.count == rhs.value.count {
                let lhsDate = lhs.value.map(\.0).max() ?? .distantPast
                let rhsDate = rhs.value.map(\.0).max() ?? .distantPast
                return lhsDate < rhsDate
            }

            return lhs.value.count < rhs.value.count
        })?.key else {
            return nil
        }

        let moodCount = grouped[dominantMood]?.count ?? 0
        return (dominantMood, Double(moodCount) / Double(moodEntries.count))
    }

    private func average(_ values: [Double]) -> Double? {
        guard values.isEmpty == false else {
            return nil
        }

        return values.reduce(0, +) / Double(values.count)
    }

    private func dates(in interval: DateInterval) -> [Date] {
        let lastIncludedDay = calendar.date(byAdding: .day, value: -1, to: interval.end) ?? interval.end
        var days: [Date] = []
        var current = calendar.startOfDay(for: interval.start)
        let end = calendar.startOfDay(for: lastIncludedDay)

        while current <= end {
            days.append(current)

            guard let next = calendar.date(byAdding: .day, value: 1, to: current) else {
                break
            }

            current = next
        }

        return days
    }
}
