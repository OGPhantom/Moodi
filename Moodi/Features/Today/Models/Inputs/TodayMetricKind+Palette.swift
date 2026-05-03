//
//  TodayMetricKind+Palette.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

extension TodayMetricKind {
    func tileGradientColors(for colorScheme: ColorScheme) -> [Color] {
        switch (self, colorScheme) {
        case (.sleep, .light):
            [
                Color(red: 0.79, green: 0.82, blue: 0.98),
                Color(red: 0.89, green: 0.84, blue: 0.98)
            ]
        case (.sleep, .dark):
            [
                Color(red: 0.18, green: 0.21, blue: 0.36),
                Color(red: 0.28, green: 0.24, blue: 0.42)
            ]
        case (.activity, .light):
            [
                Color(red: 0.77, green: 0.90, blue: 0.98),
                Color(red: 0.83, green: 0.92, blue: 0.95)
            ]
        case (.activity, .dark):
            [
                Color(red: 0.16, green: 0.25, blue: 0.34),
                Color(red: 0.19, green: 0.31, blue: 0.39)
            ]
        case (.screenTime, .light):
            [
                Color(red: 0.79, green: 0.90, blue: 0.92),
                Color(red: 0.86, green: 0.95, blue: 0.91)
            ]
        case (.screenTime, .dark):
            [
                Color(red: 0.13, green: 0.24, blue: 0.27),
                Color(red: 0.18, green: 0.31, blue: 0.30)
            ]
        case (.steps, .light):
            [
                Color(red: 0.89, green: 0.86, blue: 0.96),
                Color(red: 0.95, green: 0.89, blue: 0.91)
            ]
        case (.steps, .dark):
            [
                Color(red: 0.24, green: 0.20, blue: 0.33),
                Color(red: 0.31, green: 0.24, blue: 0.31)
            ]
        @unknown default:
            [
                Color.white.opacity(0.60),
                Color.white.opacity(0.48)
            ]
        }
    }

    func tilePrimaryGlowColor(for colorScheme: ColorScheme) -> Color {
        switch (self, colorScheme) {
        case (.sleep, .light):
            Color(red: 0.50, green: 0.53, blue: 0.90).opacity(0.34)
        case (.sleep, .dark):
            Color(red: 0.48, green: 0.43, blue: 0.83).opacity(0.22)
        case (.activity, .light):
            Color(red: 0.42, green: 0.72, blue: 0.88).opacity(0.28)
        case (.activity, .dark):
            Color(red: 0.35, green: 0.64, blue: 0.76).opacity(0.18)
        case (.screenTime, .light):
            Color(red: 0.38, green: 0.78, blue: 0.74).opacity(0.30)
        case (.screenTime, .dark):
            Color(red: 0.33, green: 0.69, blue: 0.64).opacity(0.18)
        case (.steps, .light):
            Color(red: 0.78, green: 0.60, blue: 0.77).opacity(0.24)
        case (.steps, .dark):
            Color(red: 0.72, green: 0.52, blue: 0.70).opacity(0.16)
        @unknown default:
            Color.white.opacity(0.18)
        }
    }

    func tileSecondaryGlowColor(for colorScheme: ColorScheme) -> Color {
        switch (self, colorScheme) {
        case (.sleep, .light):
            Color.white.opacity(0.42)
        case (.sleep, .dark):
            Color.white.opacity(0.08)
        case (.activity, .light):
            Color.white.opacity(0.38)
        case (.activity, .dark):
            Color.white.opacity(0.08)
        case (.screenTime, .light):
            Color.white.opacity(0.40)
        case (.screenTime, .dark):
            Color.white.opacity(0.08)
        case (.steps, .light):
            Color.white.opacity(0.34)
        case (.steps, .dark):
            Color.white.opacity(0.08)
        @unknown default:
            Color.white.opacity(0.10)
        }
    }

    func tileStrokeColor(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.62)
        case .dark:
            Color.white.opacity(0.08)
        @unknown default:
            Color.white.opacity(0.20)
        }
    }

    func analyticsLineColor(for colorScheme: ColorScheme) -> Color {
        switch (self, colorScheme) {
        case (.sleep, .light):
            Color(red: 0.41, green: 0.43, blue: 0.87)
        case (.sleep, .dark):
            Color(red: 0.62, green: 0.61, blue: 0.94)
        case (.activity, .light):
            Color(red: 0.27, green: 0.64, blue: 0.82)
        case (.activity, .dark):
            Color(red: 0.48, green: 0.78, blue: 0.90)
        case (.screenTime, .light):
            Color(red: 0.23, green: 0.67, blue: 0.61)
        case (.screenTime, .dark):
            Color(red: 0.45, green: 0.82, blue: 0.74)
        case (.steps, .light):
            Color(red: 0.70, green: 0.42, blue: 0.69)
        case (.steps, .dark):
            Color(red: 0.84, green: 0.62, blue: 0.80)
        @unknown default:
            MoodiPalette.accent
        }
    }

    var analyticsTitle: String {
        "Avg \(title)"
    }

    func formattedAnalyticsValue(_ value: Double?) -> String {
        guard let value else {
            return "--"
        }

        switch self {
        case .sleep, .screenTime:
            return formattedAnalyticsHours(value)
        case .activity:
            return "\(Int(value.rounded()).formatted()) min"
        case .steps:
            return Int(value.rounded()).formatted()
        }
    }

    func formattedTrendAxisValue(_ value: Double) -> String {
        switch self {
        case .sleep, .screenTime:
            "\(value.formatted(.number.precision(.fractionLength(0...1))))h"
        case .activity:
            "\(Int(value.rounded()).formatted())m"
        case .steps:
            if value >= 1_000 {
                "\(Int((value / 1_000).rounded()).formatted())k"
            } else {
                Int(value.rounded()).formatted()
            }
        }
    }

    private func formattedAnalyticsHours(_ value: Double) -> String {
        let totalMinutes = Int((value * 60).rounded())
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60

        if minutes == 0 {
            return "\(hours)h"
        }

        return "\(hours)h \(minutes)m"
    }
}
