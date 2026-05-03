//
//  AnalyticsEmptyStateCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct AnalyticsEmptyStateCard: View {
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "chart.line.text.clipboard")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(MoodiPalette.accent)
                .padding(14)
                .background(
                    Circle()
                        .fill(MoodiPalette.accent.opacity(0.12))
                )

            VStack(spacing: 8) {
                Text(title)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(MoodiUI.cardPadding)
        .background {
            SectionCardBackground()
        }
    }
}
