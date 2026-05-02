//
//  TodayInputTile.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct TodayInputTile: View {
    @Environment(\.colorScheme) private var colorScheme

    let kind: TodayMetricKind
    let value: Double?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 14) {
                Label(kind.title, systemImage: kind.systemImage)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .labelStyle(.titleAndIcon)

                Spacer(minLength: 0)

                VStack(alignment: .leading, spacing: 4) {
                    Text(kind.formattedTileValue(value))
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text(kind.formattedTileUnit(value))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, minHeight: MoodiUI.tileMinHeight, alignment: .leading)
            .padding(18)
            .background {
                CardBackground(
                    cornerRadius: MoodiUI.tileCornerRadius,
                    gradientColors: gradientColors,
                    primaryGlowColor: primaryGlowColor,
                    secondaryGlowColor: secondaryGlowColor,
                    strokeColor: strokeColor
                )
            }
            .contentShape(.rect(cornerRadius: MoodiUI.tileCornerRadius))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(kind.title), \(kind.formattedTileValue(value)) \(kind.formattedTileUnit(value))")
        .accessibilityHint("Double-tap to edit.")
    }

    private var gradientColors: [Color] {
        switch (kind, colorScheme) {
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

    private var primaryGlowColor: Color {
        switch (kind, colorScheme) {
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

    private var secondaryGlowColor: Color {
        switch (kind, colorScheme) {
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

    private var strokeColor: Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.62)
        case .dark:
            Color.white.opacity(0.08)
        @unknown default:
            Color.white.opacity(0.20)
        }
    }
}
