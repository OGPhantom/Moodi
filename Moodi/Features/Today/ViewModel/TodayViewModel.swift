//
//  TodayViewModel.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class TodayViewModel {
    var currentDate: Date
    var sleepHours: Double?
    var steps: Double?
    var screenTimeHours: Double?
    var activityMinutes: Double?
    var manualMood: TodayMood?
    private(set) var prediction: MoodPredictionResult?
    private(set) var predictionError: String?

    private let predictionService: MoodPredictionService

    init(
        currentDate: Date = .now,
        predictionService: MoodPredictionService? = nil
    ) {
        self.currentDate = currentDate
        self.predictionService = predictionService ?? MoodPredictionService()
    }

    var heroState: TodayHeroDisplayState {
        if predictionError != nil {
            return .unavailable
        }

        guard let displayedMood, let prediction else {
            return .empty
        }

        return .predicted(
            mood: displayedMood,
            confidence: prediction.confidencePercentage,
            isAdjusted: manualMood != nil
        )
    }

    var displayedMood: TodayMood? {
        manualMood ?? predictedMood
    }

    var predictedMood: TodayMood? {
        TodayMood(predictionLabel: prediction?.mood)
    }

    func value(for kind: TodayMetricKind) -> Double? {
        switch kind {
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

    func update(_ kind: TodayMetricKind, to newValue: Double) {
        switch kind {
        case .sleep:
            sleepHours = newValue
        case .activity:
            activityMinutes = newValue
        case .screenTime:
            screenTimeHours = newValue
        case .steps:
            steps = newValue
        }

        manualMood = nil
        refreshPrediction()
    }

    func chooseMood(_ mood: TodayMood) {
        manualMood = mood
    }

    func clearManualMood() {
        manualMood = nil
    }

    private func refreshPrediction() {
        guard let metrics else {
            prediction = nil
            predictionError = nil
            manualMood = nil
            return
        }

        do {
            prediction = try predictionService.predict(using: metrics)
            predictionError = nil
        } catch {
            prediction = nil
            predictionError = error.localizedDescription
            manualMood = nil
        }
    }

    private var metrics: DailyBehaviorMetrics? {
        guard
            let sleepHours,
            let steps,
            let screenTimeHours,
            let activityMinutes
        else {
            return nil
        }

        return DailyBehaviorMetrics(
            sleepHours: sleepHours,
            steps: steps,
            screenTime: screenTimeHours,
            activityMinutes: activityMinutes
        )
    }
}

extension TodayViewModel {
    static func previewFilled() -> TodayViewModel {
        let model = TodayViewModel(currentDate: .now)
        model.sleepHours = 7.5
        model.steps = 8_500
        model.screenTimeHours = 3.75
        model.activityMinutes = 45
        model.prediction = MoodPredictionResult(mood: "Happy", confidence: 0.84)
        return model
    }

    static func previewAdjusted() -> TodayViewModel {
        let model = previewFilled()
        model.manualMood = .neutral
        return model
    }
}
