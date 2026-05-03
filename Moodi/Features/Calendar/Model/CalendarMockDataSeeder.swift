//
//  CalendarMockDataSeeder.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation
import SwiftData

enum CalendarMockDataSeeder {
    private static let seededFlagKey = "moodi.calendar.mockSeed.v1"

    static func seedIfNeeded(using modelContext: ModelContext, calendar: Calendar = .autoupdatingCurrent) throws {
        guard UserDefaults.standard.bool(forKey: seededFlagKey) == false else {
            return
        }

        let today = calendar.startOfDay(for: .now)
        let rangeStart = calendar.date(byAdding: .day, value: -50, to: today) ?? today

        var descriptor = FetchDescriptor<DailyMoodEntry>(
            predicate: #Predicate<DailyMoodEntry> { entry in
                entry.date >= rangeStart && entry.date < today
            }
        )
        descriptor.fetchLimit = 50

        let existingEntries = try modelContext.fetch(descriptor)
        let existingDays = Set(existingEntries.map { calendar.startOfDay(for: $0.date) })

        for offset in 1...50 {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else {
                continue
            }

            let day = calendar.startOfDay(for: date)
            guard existingDays.contains(day) == false else {
                continue
            }

            modelContext.insert(makeMockEntry(for: day, index: offset))
        }

        try modelContext.save()
        UserDefaults.standard.set(true, forKey: seededFlagKey)
    }

    private static func makeMockEntry(for date: Date, index: Int) -> DailyMoodEntry {
        let predictedMood = predictedMood(for: index)
        let manualMood = index.isMultiple(of: 6) ? adjustedMood(for: predictedMood) : nil
        let sleepHours = 5.5 + Double((index * 3) % 9) * 0.5
        let activityMinutes = 20 + Double((index * 7) % 11) * 5
        let screenTimeHours = 2.0 + Double((index * 5) % 18) * 0.25
        let steps = Double(4_000 + ((index * 613) % 7_500))
        let confidence = 0.68 + Double((index * 9) % 20) / 100

        return DailyMoodEntry(
            date: date,
            sleepHours: sleepHours,
            steps: steps,
            screenTimeHours: screenTimeHours,
            activityMinutes: activityMinutes,
            predictedMood: predictedMood,
            predictionConfidence: confidence,
            manualMood: manualMood,
            updatedAt: date
        )
    }

    private static func predictedMood(for index: Int) -> TodayMood {
        let pattern: [TodayMood] = [.happy, .neutral, .happy, .neutral, .sad, .neutral, .happy, .sad]
        return pattern[index % pattern.count]
    }

    private static func adjustedMood(for mood: TodayMood) -> TodayMood {
        switch mood {
        case .sad:
            .neutral
        case .neutral:
            .happy
        case .happy:
            .neutral
        }
    }
}
