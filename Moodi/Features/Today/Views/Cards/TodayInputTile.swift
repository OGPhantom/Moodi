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
        kind.tileGradientColors(for: colorScheme)
    }

    private var primaryGlowColor: Color {
        kind.tilePrimaryGlowColor(for: colorScheme)
    }

    private var secondaryGlowColor: Color {
        kind.tileSecondaryGlowColor(for: colorScheme)
    }

    private var strokeColor: Color {
        kind.tileStrokeColor(for: colorScheme)
    }
}
