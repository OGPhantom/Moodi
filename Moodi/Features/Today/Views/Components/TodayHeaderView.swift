//
//  TodayHeaderView.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct TodayHeaderView: View {
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(date, format: .dateTime.weekday(.wide).month(.wide).day())
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.primary)

            Text("How are you feeling?")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}
