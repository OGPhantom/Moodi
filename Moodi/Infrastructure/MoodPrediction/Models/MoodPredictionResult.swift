//
//  MoodPredictionResult.swift
//  Moodi
//
//  Created by Никита Сторчай on 29.04.2026.
//

import Foundation

struct MoodPredictionResult: Equatable {
    let mood: String
    let confidence: Double

    var confidencePercentage: Int {
        Int((confidence * 100).rounded())
    }
}
