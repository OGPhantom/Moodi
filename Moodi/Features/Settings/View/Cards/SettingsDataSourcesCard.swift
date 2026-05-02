//
//  SettingsDataSourcesCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SettingsDataSourcesCard: View {
    let isHealthAccessHighlighted: Bool
    let isScreenTimeHighlighted: Bool
    let toggleHealthAccess: () -> Void
    let toggleScreenTime: () -> Void

    var body: some View {
        SettingsSectionCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Data Sources")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.primary)

                VStack(spacing: 12) {
                    SettingsSourceButton(
                        title: "Health Access",
                        subtitle: "Sleep, activity, and steps to improve daily mood prediction.",
                        systemImage: "heart.text.square",
                        isActive: isHealthAccessHighlighted,
                        activeGradientColors: healthGradientColors,
                        primaryGlowColor: healthPrimaryGlowColor,
                        secondaryGlowColor: healthSecondaryGlowColor,
                        action: toggleHealthAccess
                    )

                    SettingsSourceButton(
                        title: "Screen Time",
                        subtitle: "Screen time patterns to refine each day's on-device prediction.",
                        systemImage: "hourglass",
                        isActive: isScreenTimeHighlighted,
                        activeGradientColors: screenTimeGradientColors,
                        primaryGlowColor: screenTimePrimaryGlowColor,
                        secondaryGlowColor: screenTimeSecondaryGlowColor,
                        action: toggleScreenTime
                    )
                }
            }
        }
    }

    private var healthGradientColors: [Color] {
        [
            Color(red: 0.30, green: 0.70, blue: 0.98),
            Color(red: 0.43, green: 0.85, blue: 0.93)
        ]
    }

    private var healthPrimaryGlowColor: Color {
        Color(red: 0.22, green: 0.78, blue: 1.00).opacity(0.42)
    }

    private var healthSecondaryGlowColor: Color {
        Color.white.opacity(0.36)
    }

    private var screenTimeGradientColors: [Color] {
        [
            Color(red: 0.67, green: 0.43, blue: 0.98),
            Color(red: 0.98, green: 0.52, blue: 0.76)
        ]
    }

    private var screenTimePrimaryGlowColor: Color {
        Color(red: 0.90, green: 0.44, blue: 1.00).opacity(0.40)
    }

    private var screenTimeSecondaryGlowColor: Color {
        Color.white.opacity(0.34)
    }
}
