//
//  CalendarDayMoodCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct CalendarDayMoodCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let entry: DailyMoodEntry?

    var body: some View {
        Group {
            if let displayedMood {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Mood")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.76))

                            Text(displayedMood.title)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                        }

                        Spacer(minLength: 0)

                        Text(statusTitle)
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(displayedMood.pillFillColor(for: colorScheme), in: Capsule())
                    }

                    if let confidenceText {
                        Text(confidenceText)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.82))
                    }
                }
                .padding(MoodiUI.cardPadding)
                .background {
                    CardBackground(
                        cornerRadius: MoodiUI.heroCornerRadius,
                        gradientColors: displayedMood.heroGradientColors(for: colorScheme),
                        primaryGlowColor: displayedMood.pillFillColor(for: colorScheme),
                        secondaryGlowColor: Color.white.opacity(colorScheme == .dark ? 0.08 : 0.18),
                        strokeColor: Color.white.opacity(colorScheme == .dark ? 0.10 : 0.16)
                    )
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Mood")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("No entry for this day")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.primary)

                    Text("Daily mood history will appear here once an entry is saved.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
                .padding(MoodiUI.cardPadding)
                .background {
                    SectionCardBackground()
                }
            }
        }
    }

    private var displayedMood: TodayMood? {
        entry?.manualMood ?? entry?.predictedMood
    }

    private var statusTitle: String {
        if entry?.manualMood != nil {
            return "Adjusted"
        }

        return "Predicted"
    }

    private var confidenceText: String? {
        guard entry?.manualMood == nil, let confidence = entry?.predictionConfidence else {
            return nil
        }

        return "Prediction confidence \(Int((confidence * 100).rounded()))%"
    }
}
