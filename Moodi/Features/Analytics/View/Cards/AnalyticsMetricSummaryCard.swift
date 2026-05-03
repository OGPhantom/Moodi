//
//  AnalyticsMetricSummaryCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct AnalyticsMetricSummaryCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let kind: TodayMetricKind
    let value: Double?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(kind.analyticsTitle, systemImage: kind.systemImage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .labelStyle(.titleAndIcon)

            Spacer(minLength: 0)

            Text(kind.formattedAnalyticsValue(value))
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.78)
        }
        .frame(maxWidth: .infinity, minHeight: MoodiUI.tileMinHeight, alignment: .leading)
        .padding(18)
        .background {
            CardBackground(
                cornerRadius: MoodiUI.tileCornerRadius,
                gradientColors: kind.tileGradientColors(for: colorScheme),
                primaryGlowColor: kind.tilePrimaryGlowColor(for: colorScheme),
                secondaryGlowColor: kind.tileSecondaryGlowColor(for: colorScheme),
                strokeColor: kind.tileStrokeColor(for: colorScheme)
            )
        }
        .accessibilityLabel("\(kind.analyticsTitle), \(kind.formattedAnalyticsValue(value))")
    }
}
