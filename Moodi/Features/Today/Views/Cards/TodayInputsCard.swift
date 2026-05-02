//
//  TodayInputsCard.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct TodayInputsCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let model: TodayViewModel
    let action: (TodayMetricKind) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: MoodiUI.gridSpacing),
        GridItem(.flexible(), spacing: MoodiUI.gridSpacing)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your daily rhythm")
                .font(.title3)
                .bold()
                .foregroundStyle(.primary)

            LazyVGrid(columns: columns, spacing: MoodiUI.gridSpacing) {
                ForEach(TodayMetricKind.allCases) { kind in
                    TodayInputTile(
                        kind: kind,
                        value: model.value(for: kind),
                        action: { action(kind) }
                    )
                }
            }
        }
        .padding(MoodiUI.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                .fill(cardFill)
                .overlay {
                    RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                        .strokeBorder(cardStroke, lineWidth: 1)
                }
        }
    }

    private var cardFill: Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.72)
        case .dark:
            Color.white.opacity(0.06)
        @unknown default:
            Color.white.opacity(0.72)
        }
    }

    private var cardStroke: Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.48)
        case .dark:
            Color.white.opacity(0.08)
        @unknown default:
            Color.white.opacity(0.48)
        }
    }
}
