//
//  DailyMoodEntry.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import Foundation
import SwiftData

@Model
final class DailyMoodEntry {
    var date: Date
    var sleepHours: Double?
    var steps: Double?
    var screenTimeHours: Double?
    var activityMinutes: Double?
    var predictedMood: TodayMood?
    var predictionConfidence: Double?
    var manualMood: TodayMood?
    var updatedAt: Date

    init(
        date: Date,
        sleepHours: Double? = nil,
        steps: Double? = nil,
        screenTimeHours: Double? = nil,
        activityMinutes: Double? = nil,
        predictedMood: TodayMood? = nil,
        predictionConfidence: Double? = nil,
        manualMood: TodayMood? = nil,
        updatedAt: Date = .now
    ) {
        self.date = date
        self.sleepHours = sleepHours
        self.steps = steps
        self.screenTimeHours = screenTimeHours
        self.activityMinutes = activityMinutes
        self.predictedMood = predictedMood
        self.predictionConfidence = predictionConfidence
        self.manualMood = manualMood
        self.updatedAt = updatedAt
    }

    var hasAnyData: Bool {
        sleepHours != nil ||
        steps != nil ||
        screenTimeHours != nil ||
        activityMinutes != nil ||
        predictedMood != nil ||
        manualMood != nil
    }
}
