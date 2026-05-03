//
//  AnalyticsPeriodPicker.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct AnalyticsPeriodPicker: View {
    @Bindable var model: AnalyticsViewModel

    var body: some View {
        HStack(spacing: 6) {
            ForEach(AnalyticsPeriod.allCases) { period in
                Button {
                    withAnimation(.snappy(duration: 0.22, extraBounce: 0.02)) {
                        model.selectedPeriod = period
                    }
                } label: {
                    Text(period.title)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(model.selectedPeriod == period ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(model.selectedPeriod == period ? MoodiPalette.accent : .clear)
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.primary.opacity(0.05))
        )
    }
}
