//
//  AnalyticsMoodSummaryCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct AnalyticsMoodSummaryCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let summary: AnalyticsSummary
    let percentText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Mood")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(titleColor)

            Spacer(minLength: 0)

            VStack(alignment: .leading, spacing: 6) {
                Text(summary.dominantMood?.title ?? "--")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(valueColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text(percentText)
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(valueColor.opacity(0.78))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 168, alignment: .leading)
        .padding(MoodiUI.cardPadding)
        .background {
            if let mood = summary.dominantMood {
                CardBackground(
                    cornerRadius: MoodiUI.cardCornerRadius,
                    gradientColors: mood.heroGradientColors(for: colorScheme),
                    primaryGlowColor: Color.white.opacity(colorScheme == .dark ? 0.10 : 0.18),
                    secondaryGlowColor: mood.calendarGradientColors(for: colorScheme).last?.opacity(colorScheme == .dark ? 0.24 : 0.30) ?? Color.clear,
                    strokeColor: Color.white.opacity(colorScheme == .dark ? 0.10 : 0.22)
                )
            } else {
                SectionCardBackground()
            }
        }
        .accessibilityLabel(accessibilityLabel)
    }

    private var titleColor: Color {
        summary.dominantMood == nil ? .secondary : Color.white.opacity(0.78)
    }

    private var valueColor: Color {
        summary.dominantMood == nil ? .primary : .white
    }

    private var accessibilityLabel: String {
        if let mood = summary.dominantMood {
            return "Mood, \(mood.title), \(percentText)"
        }

        return "Mood, no data"
    }
}
