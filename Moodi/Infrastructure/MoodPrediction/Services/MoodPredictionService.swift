//
//  MoodPredictionService.swift
//  Moodi
//
//  Created by Никита Сторчай on 29.04.2026.
//

import CoreML

final class MoodPredictionService {
    private lazy var model: MoodPredictor_GradientBoosting? = {
        try? MoodPredictor_GradientBoosting(configuration: MLModelConfiguration())
    }()

    func predict(using metrics: DailyBehaviorMetrics) throws -> MoodPredictionResult {
        guard let model else {
            throw MoodPredictionServiceError.unavailable
        }

        do {
            let output = try model.prediction(
                sleep_hours: metrics.sleepHours,
                steps: metrics.steps,
                screen_time: metrics.screenTime,
                activity_minutes: metrics.activityMinutes
            )

            let confidence = output.classProbability[output.mood] ?? output.classProbability.values.max() ?? 0
            let mood = output.mood
                .replacingOccurrences(of: "_", with: " ")
                .capitalized

            return MoodPredictionResult(mood: mood, confidence: confidence)
        } catch {
            throw MoodPredictionServiceError.predictionFailed(error.localizedDescription)
        }
    }
}
