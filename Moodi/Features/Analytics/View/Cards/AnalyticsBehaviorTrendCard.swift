//
//  AnalyticsBehaviorTrendCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Charts
import SwiftUI

struct AnalyticsBehaviorTrendCard: View {
    @Environment(\.colorScheme) private var colorScheme

    @Bindable var model: AnalyticsViewModel
    let points: [AnalyticsMetricTrendPoint]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Behavior trends")
                .font(.title3.bold())
                .foregroundStyle(.primary)

            AnalyticsMetricPicker(model: model)

            if points.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(lineColor)

                    Text("No \(model.selectedMetric.title.lowercased()) data in this period yet.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, minHeight: 228)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.primary.opacity(0.03))
                )
            } else {
                Chart {
                    ForEach(points) { point in
                        AreaMark(
                            x: .value("Day", point.date),
                            y: .value(model.selectedMetric.title, point.value)
                        )
                        .foregroundStyle(areaGradient)
                        .interpolationMethod(.catmullRom)

                        LineMark(
                            x: .value("Day", point.date),
                            y: .value(model.selectedMetric.title, point.value)
                        )
                        .foregroundStyle(lineColor)
                        .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .interpolationMethod(.catmullRom)
                    }

                    if let lastPoint = points.last {
                        PointMark(
                            x: .value("Day", lastPoint.date),
                            y: .value(model.selectedMetric.title, lastPoint.value)
                        )
                        .foregroundStyle(lineColor)
                        .symbolSize(42)
                    }
                }
                .frame(height: 228)
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: xAxisMarkCount)) { value in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 3]))
                            .foregroundStyle(.secondary.opacity(0.18))
                        AxisTick()
                        AxisValueLabel {
                            if let date = value.as(Date.self) {
                                xAxisLabel(for: date)
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 3]))
                            .foregroundStyle(.secondary.opacity(0.18))
                        AxisTick()
                        AxisValueLabel {
                            if let amount = value.as(Double.self) {
                                Text(model.selectedMetric.formattedTrendAxisValue(amount))
                            }
                        }
                    }
                }
            }
        }
        .padding(MoodiUI.cardPadding)
        .background {
            SectionCardBackground()
        }
    }

    private var lineColor: Color {
        model.selectedMetric.analyticsLineColor(for: colorScheme)
    }

    private var areaGradient: LinearGradient {
        LinearGradient(
            colors: [
                lineColor.opacity(colorScheme == .dark ? 0.28 : 0.24),
                lineColor.opacity(0.04)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var xAxisMarkCount: Int {
        switch model.selectedPeriod {
        case .week:
            7
        case .month:
            6
        case .year, .allTime:
            4
        }
    }

    @ViewBuilder
    private func xAxisLabel(for date: Date) -> some View {
        switch model.selectedPeriod {
        case .week:
            Text(date, format: .dateTime.weekday(.narrow))
        case .month:
            Text(date, format: .dateTime.day())
        case .year, .allTime:
            Text(date, format: .dateTime.month(.abbreviated))
        }
    }
}
