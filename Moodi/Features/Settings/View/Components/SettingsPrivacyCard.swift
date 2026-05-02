//
//  SettingsPrivacyCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SettingsPrivacyCard: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Privacy")
                .font(.headline)
                .foregroundStyle(.white.opacity(0.74))

            VStack(alignment: .leading, spacing: 8) {
                Text("All data is processed on device.")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)

                Text("Moods, sleep, activity, screen time, and steps stay local. Predictions run here too, so your history remains private.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.80))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(MoodiUI.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            CardBackground(
                cornerRadius: MoodiUI.cardCornerRadius,
                gradientColors: gradientColors,
                primaryGlowColor: primaryGlowColor,
                secondaryGlowColor: secondaryGlowColor,
                strokeColor: strokeColor
            )
        }
    }

    private var gradientColors: [Color] {
        switch colorScheme {
        case .light:
            [
                Color(red: 0.24, green: 0.31, blue: 0.74),
                Color(red: 0.38, green: 0.39, blue: 0.81),
                Color(red: 0.64, green: 0.45, blue: 0.78)
            ]
        case .dark:
            [
                Color(red: 0.10, green: 0.12, blue: 0.31),
                Color(red: 0.18, green: 0.19, blue: 0.44),
                Color(red: 0.30, green: 0.22, blue: 0.45)
            ]
        @unknown default:
            [
                Color(red: 0.24, green: 0.31, blue: 0.74),
                Color(red: 0.38, green: 0.39, blue: 0.81),
                Color(red: 0.64, green: 0.45, blue: 0.78)
            ]
        }
    }

    private var primaryGlowColor: Color {
        switch colorScheme {
        case .light:
            Color(red: 0.76, green: 0.65, blue: 0.92).opacity(0.34)
        case .dark:
            Color(red: 0.62, green: 0.48, blue: 0.88).opacity(0.22)
        @unknown default:
            Color(red: 0.76, green: 0.65, blue: 0.92).opacity(0.34)
        }
    }

    private var secondaryGlowColor: Color {
        switch colorScheme {
        case .light:
            Color(red: 0.64, green: 0.77, blue: 0.98).opacity(0.26)
        case .dark:
            Color(red: 0.42, green: 0.62, blue: 0.96).opacity(0.16)
        @unknown default:
            Color(red: 0.64, green: 0.77, blue: 0.98).opacity(0.26)
        }
    }

    private var strokeColor: Color {
        Color.white.opacity(colorScheme == .dark ? 0.10 : 0.18)
    }
}
