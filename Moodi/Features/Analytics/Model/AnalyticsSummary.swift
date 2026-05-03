//
//  AnalyticsSummary.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation

struct AnalyticsSummary {
    let dominantMood: TodayMood?
    let dominantMoodShare: Double?
    let averageSleep: Double?
    let averageActivity: Double?
    let averageScreenTime: Double?
    let averageSteps: Double?
    let loggedDayCount: Int

    func averageValue(for metric: TodayMetricKind) -> Double? {
        switch metric {
        case .sleep:
            averageSleep
        case .activity:
            averageActivity
        case .screenTime:
            averageScreenTime
        case .steps:
            averageSteps
        }
    }
}
