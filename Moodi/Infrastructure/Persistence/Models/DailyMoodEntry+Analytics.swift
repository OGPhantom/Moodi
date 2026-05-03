//
//  DailyMoodEntry+Analytics.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation

extension DailyMoodEntry {
    var effectiveMood: TodayMood? {
        manualMood ?? predictedMood
    }

    func value(for metric: TodayMetricKind) -> Double? {
        switch metric {
        case .sleep:
            sleepHours
        case .activity:
            activityMinutes
        case .screenTime:
            screenTimeHours
        case .steps:
            steps
        }
    }
}
