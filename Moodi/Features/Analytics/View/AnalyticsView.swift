//
//  AnalyticsView.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI
import SwiftData

struct AnalyticsView: View {
    @Query(sort: \DailyMoodEntry.date) private var entries: [DailyMoodEntry]

    @State private var model = AnalyticsViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: MoodiUI.gridSpacing),
        GridItem(.flexible(), spacing: MoodiUI.gridSpacing)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MoodiUI.sectionSpacing) {
                    AnalyticsPeriodPicker(model: model)

                    if model.shouldShowEmptyState(for: entries) {
                        AnalyticsEmptyStateCard(
                            title: model.emptyStateTitle(for: entries),
                            message: model.emptyStateMessage(for: entries)
                        )
                    } else {
                        summarySection

                        AnalyticsMoodTimelineCard(
                            points: model.moodTimelinePoints(from: entries)
                        )

                        AnalyticsBehaviorTrendCard(
                            model: model,
                            points: model.metricTrendPoints(from: entries)
                        )
                    }
                }
                .padding(.horizontal, MoodiUI.screenPadding)
                .padding(.top, MoodiUI.topSpacing)
                .padding(.bottom, MoodiUI.bottomSpacing)
            }
            .navigationTitle("Analytics")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background {
                AppBackground()
            }
        }
    }

    private var summarySection: some View {
        let summary = model.summary(from: entries)

        return VStack(alignment: .leading, spacing: MoodiUI.gridSpacing) {
            AnalyticsMoodSummaryCard(
                summary: summary,
                percentText: model.percentText(for: summary.dominantMoodShare)
            )

            LazyVGrid(columns: columns, spacing: MoodiUI.gridSpacing) {
                ForEach(TodayMetricKind.allCases) { metric in
                    AnalyticsMetricSummaryCard(
                        kind: metric,
                        value: summary.averageValue(for: metric)
                    )
                }
            }
        }
    }
}

#Preview {
    AnalyticsView()
        .modelContainer(for: DailyMoodEntry.self, inMemory: true)
}
