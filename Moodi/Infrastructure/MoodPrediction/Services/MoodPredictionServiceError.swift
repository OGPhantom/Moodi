//
//  MoodPredictionServiceError.swift
//  Moodi
//
//  Created by Никита Сторчай on 29.04.2026.
//

import Foundation

enum MoodPredictionServiceError: LocalizedError {
    case unavailable
    case predictionFailed(String)

    var errorDescription: String? {
        switch self {
        case .unavailable:
            "The on-device mood model is unavailable."
        case .predictionFailed(let details):
            "Prediction failed. \(details)"
        }
    }
}
