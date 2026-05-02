//
//  TodayViewModel.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import Foundation
import Observation
import SwiftData

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
    @ObservationIgnored private var modelContext: ModelContext?
    @ObservationIgnored private var storedEntry: DailyMoodEntry?
    @ObservationIgnored private var hasLoadedFromStore = false

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

    func configure(modelContext: ModelContext) {
        self.modelContext = modelContext

        guard hasLoadedFromStore == false else {
            return
        }

        hasLoadedFromStore = true
        loadStoredEntry()
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
        refreshPrediction(persist: true)
    }

    func chooseMood(_ mood: TodayMood) {
        manualMood = mood
        persistCurrentDay()
    }

    func clearManualMood() {
        manualMood = nil
        persistCurrentDay()
    }

    func clearStoredState() {
        sleepHours = nil
        steps = nil
        screenTimeHours = nil
        activityMinutes = nil
        manualMood = nil
        prediction = nil
        predictionError = nil
        storedEntry = nil
    }

    private func refreshPrediction(persist: Bool = false) {
        guard let metrics else {
            prediction = nil
            predictionError = nil
            manualMood = nil

            if persist {
                persistCurrentDay()
            }

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

        if persist {
            persistCurrentDay()
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

    private var entryDate: Date {
        Calendar.autoupdatingCurrent.startOfDay(for: currentDate)
    }

    private var hasAnyPersistableState: Bool {
        sleepHours != nil ||
        steps != nil ||
        screenTimeHours != nil ||
        activityMinutes != nil ||
        predictedMood != nil ||
        manualMood != nil
    }

    private func loadStoredEntry() {
        guard let modelContext else {
            return
        }

        do {
            storedEntry = try fetchStoredEntry(in: modelContext)
        } catch {
            storedEntry = nil
            return
        }

        guard let storedEntry else {
            return
        }

        sleepHours = storedEntry.sleepHours
        steps = storedEntry.steps
        screenTimeHours = storedEntry.screenTimeHours
        activityMinutes = storedEntry.activityMinutes
        manualMood = storedEntry.manualMood

        if let storedMood = storedEntry.predictedMood,
           let confidence = storedEntry.predictionConfidence {
            prediction = MoodPredictionResult(mood: storedMood.title, confidence: confidence)
            predictionError = nil
        } else if metrics != nil {
            refreshPrediction(persist: true)
        }
    }

    private func persistCurrentDay() {
        guard let modelContext, hasAnyPersistableState else {
            return
        }

        do {
            let entry = try storedEntry ?? fetchStoredEntry(in: modelContext) ?? createStoredEntry(in: modelContext)
            entry.sleepHours = sleepHours
            entry.steps = steps
            entry.screenTimeHours = screenTimeHours
            entry.activityMinutes = activityMinutes
            entry.predictedMood = predictedMood
            entry.predictionConfidence = prediction?.confidence
            entry.manualMood = manualMood
            entry.updatedAt = .now
            try modelContext.save()
            storedEntry = entry
        } catch {
            assertionFailure("Failed to save daily mood entry: \(error)")
        }
    }

    private func fetchStoredEntry(in modelContext: ModelContext) throws -> DailyMoodEntry? {
        let date = entryDate
        var descriptor = FetchDescriptor<DailyMoodEntry>(
            predicate: #Predicate<DailyMoodEntry> { entry in
                entry.date == date
            }
        )
        descriptor.fetchLimit = 1
        return try modelContext.fetch(descriptor).first
    }

    private func createStoredEntry(in modelContext: ModelContext) -> DailyMoodEntry {
        let entry = DailyMoodEntry(date: entryDate)
        modelContext.insert(entry)
        return entry
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
