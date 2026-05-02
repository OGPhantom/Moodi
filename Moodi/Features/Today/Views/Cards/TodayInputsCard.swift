//
//  TodayInputsCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct TodayInputsCard: View {
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
            SectionCardBackground()
        }
    }
}
