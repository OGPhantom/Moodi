//
//  AnalyticsMetricPicker.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct AnalyticsMetricPicker: View {
    @Environment(\.colorScheme) private var colorScheme

    @Bindable var model: AnalyticsViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(TodayMetricKind.allCases) { metric in
                    Button {
                        withAnimation(.snappy(duration: 0.22, extraBounce: 0.02)) {
                            model.selectedMetric = metric
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: metric.systemImage)
                                .font(.caption.weight(.semibold))

                            Text(metric.title)
                                .font(.subheadline.weight(.medium))
                        }
                        .foregroundStyle(model.selectedMetric == metric ? .white : .primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .fill(model.selectedMetric == metric ? metric.analyticsLineColor(for: colorScheme) : Color.primary.opacity(0.05))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 2)
        }
        .scrollIndicators(.hidden)
    }
}
