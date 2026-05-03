//
//  CalendarDayDetailView.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct CalendarDayDetailView: View {
    let date: Date
    let entry: DailyMoodEntry?

    private let columns = [
        GridItem(.flexible(), spacing: MoodiUI.gridSpacing),
        GridItem(.flexible(), spacing: MoodiUI.gridSpacing)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: MoodiUI.sectionSpacing) {
                header
                CalendarDayMoodCard(entry: entry)
                metricsCard
            }
            .padding(.horizontal, MoodiUI.screenPadding)
            .padding(.top, MoodiUI.topSpacing)
            .padding(.bottom, MoodiUI.bottomSpacing)
        }
        .navigationTitle(date.formatted(.dateTime.month(.wide).day()))
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .background {
            AppBackground()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(date.formatted(.dateTime.weekday(.wide)))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(date.formatted(.dateTime.month(.wide).day()))
                .font(.title)
                .bold()
                .foregroundStyle(.primary)
        }
    }

    private var metricsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Daily Inputs")
                .font(.title3)
                .bold()
                .foregroundStyle(.primary)

            LazyVGrid(columns: columns, spacing: MoodiUI.gridSpacing) {
                CalendarMetricTile(kind: .sleep, value: entry?.sleepHours)
                CalendarMetricTile(kind: .activity, value: entry?.activityMinutes)
                CalendarMetricTile(kind: .screenTime, value: entry?.screenTimeHours)
                CalendarMetricTile(kind: .steps, value: entry?.steps)
            }
        }
        .padding(MoodiUI.cardPadding)
        .background {
            SectionCardBackground()
        }
    }
}
