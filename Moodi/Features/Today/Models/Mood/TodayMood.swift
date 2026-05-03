//
//  TodayMood.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

enum TodayMood: String, CaseIterable, Identifiable, Codable, Sendable {
    case sad
    case neutral
    case happy

    var id: String {
        rawValue
    }

    init?(predictionLabel: String?) {
        guard let predictionLabel else {
            return nil
        }

        let normalized = predictionLabel.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if normalized.contains("sad") || normalized.contains("down") || normalized.contains("low") {
            self = .sad
        } else if normalized.contains("happy") || normalized.contains("good") || normalized.contains("upbeat") {
            self = .happy
        } else if normalized.contains("neutral") || normalized.contains("balanced") || normalized.contains("calm") {
            self = .neutral
        } else {
            self = .neutral
        }
    }

    var title: String {
        switch self {
        case .sad:
            "Sad"
        case .neutral:
            "Neutral"
        case .happy:
            "Happy"
        }
    }

    func heroGradientColors(for colorScheme: ColorScheme) -> [Color] {
        switch self {
        case .sad:
            switch colorScheme {
            case .light:
            [
                Color(red: 0.20, green: 0.24, blue: 0.49),
                Color(red: 0.32, green: 0.28, blue: 0.56),
                Color(red: 0.43, green: 0.36, blue: 0.66)
            ]
            case .dark:
            [
                Color(red: 0.10, green: 0.11, blue: 0.24),
                Color(red: 0.19, green: 0.17, blue: 0.35),
                Color(red: 0.30, green: 0.24, blue: 0.47)
            ]
            @unknown default:
                [
                    Color(red: 0.20, green: 0.24, blue: 0.49),
                    Color(red: 0.32, green: 0.28, blue: 0.56),
                    Color(red: 0.43, green: 0.36, blue: 0.66)
                ]
            }
        case .neutral:
            switch colorScheme {
            case .light:
            [
                Color(red: 0.29, green: 0.34, blue: 0.66),
                Color(red: 0.38, green: 0.39, blue: 0.70),
                Color(red: 0.57, green: 0.53, blue: 0.77)
            ]
            case .dark:
            [
                Color(red: 0.12, green: 0.16, blue: 0.32),
                Color(red: 0.21, green: 0.21, blue: 0.43),
                Color(red: 0.31, green: 0.28, blue: 0.50)
            ]
            @unknown default:
                [
                    Color(red: 0.29, green: 0.34, blue: 0.66),
                    Color(red: 0.38, green: 0.39, blue: 0.70),
                    Color(red: 0.57, green: 0.53, blue: 0.77)
                ]
            }
        case .happy:
            switch colorScheme {
            case .light:
            [
                Color(red: 0.41, green: 0.35, blue: 0.76),
                Color(red: 0.54, green: 0.46, blue: 0.83),
                Color(red: 0.84, green: 0.65, blue: 0.63)
            ]
            case .dark:
            [
                Color(red: 0.18, green: 0.14, blue: 0.35),
                Color(red: 0.31, green: 0.24, blue: 0.50),
                Color(red: 0.48, green: 0.33, blue: 0.43)
            ]
            @unknown default:
                [
                    Color(red: 0.41, green: 0.35, blue: 0.76),
                    Color(red: 0.54, green: 0.46, blue: 0.83),
                    Color(red: 0.84, green: 0.65, blue: 0.63)
                ]
            }
        }
    }

    func calendarGradientColors(for colorScheme: ColorScheme) -> [Color] {
        switch self {
        case .sad:
            switch colorScheme {
            case .light:
                [
                    Color(red: 0.29, green: 0.46, blue: 0.92),
                    Color(red: 0.18, green: 0.34, blue: 0.76)
                ]
            case .dark:
                [
                    Color(red: 0.16, green: 0.28, blue: 0.56),
                    Color(red: 0.10, green: 0.21, blue: 0.44)
                ]
            @unknown default:
                [
                    Color(red: 0.29, green: 0.46, blue: 0.92),
                    Color(red: 0.18, green: 0.34, blue: 0.76)
                ]
            }
        case .neutral:
            switch colorScheme {
            case .light:
                [
                    Color(red: 0.61, green: 0.58, blue: 0.82),
                    Color(red: 0.47, green: 0.50, blue: 0.72)
                ]
            case .dark:
                [
                    Color(red: 0.28, green: 0.29, blue: 0.46),
                    Color(red: 0.22, green: 0.24, blue: 0.39)
                ]
            @unknown default:
                [
                    Color(red: 0.61, green: 0.58, blue: 0.82),
                    Color(red: 0.47, green: 0.50, blue: 0.72)
                ]
            }
        case .happy:
            switch colorScheme {
            case .light:
                [
                    Color(red: 0.97, green: 0.63, blue: 0.56),
                    Color(red: 0.86, green: 0.43, blue: 0.62)
                ]
            case .dark:
                [
                    Color(red: 0.52, green: 0.27, blue: 0.30),
                    Color(red: 0.42, green: 0.20, blue: 0.33)
                ]
            @unknown default:
                [
                    Color(red: 0.97, green: 0.63, blue: 0.56),
                    Color(red: 0.86, green: 0.43, blue: 0.62)
                ]
            }
        }
    }

    func pillFillColor(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.18)
        case .dark:
            Color.white.opacity(0.12)
        @unknown default:
            Color.white.opacity(0.16)
        }
    }
}
