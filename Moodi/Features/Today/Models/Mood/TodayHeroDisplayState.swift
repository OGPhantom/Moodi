//
//  TodayHeroDisplayState.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import Foundation

enum TodayHeroDisplayState {
    case empty
    case predicted(mood: TodayMood, confidence: Int, isAdjusted: Bool)
    case unavailable

    var eyebrow: String {
        switch self {
        case .empty:
            "Ready for today's check-in"
        case .unavailable:
            "On-device prediction"
        case .predicted:
            "Based on today's inputs"
        }
    }

    var title: String {
        switch self {
        case .empty:
            "No data yet"
        case .predicted(let mood, _, _):
            mood.title
        case .unavailable:
            "Prediction unavailable"
        }
    }

    var pillText: String {
        switch self {
        case .empty:
            "Waiting for inputs"
        case .predicted(_, let confidence, let isAdjusted):
            isAdjusted ? "Adjusted" : "\(confidence)%"
        case .unavailable:
            "On-device model unavailable"
        }
    }

    var pillSystemImage: String {
        switch self {
        case .empty:
            "ellipsis.circle"
        case .predicted:
            "waveform.path.ecg"
        case .unavailable:
            "exclamationmark.triangle"
        }
    }

    var isInteractive: Bool {
        switch self {
        case .predicted:
            true
        case .empty, .unavailable:
            false
        }
    }

    var mood: TodayMood? {
        switch self {
        case .predicted(let mood, _, _):
            mood
        case .empty, .unavailable:
            nil
        }
    }

    var accessibilityLabel: String {
        switch self {
        case .empty:
            "Ready for today's check-in. Waiting for inputs."
        case .predicted(let mood, let confidence, let isAdjusted):
            isAdjusted
                ? "\(mood.title). Adjusted manually."
                : "\(mood.title). Prediction confidence \(confidence) percent."
        case .unavailable:
            "Prediction unavailable. On-device model unavailable."
        }
    }
}
