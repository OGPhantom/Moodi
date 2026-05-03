//
//  CalendarGridCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct CalendarGridCard: View {
    let weekdaySymbols: [String]
    let days: [CalendarDay]
    let rowCount: Int
    let entryProvider: (Date) -> DailyMoodEntry?

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)

    var body: some View {
        GeometryReader { proxy in
            let verticalSpacing: CGFloat = 8
            let contentPadding = MoodiUI.cardPadding * 2
            let weekdayRowHeight: CGFloat = 18
            let headerSpacing: CGFloat = 16
            let availableHeight = proxy.size.height - contentPadding - weekdayRowHeight - headerSpacing
            let rowHeight = max(56, (availableHeight - (CGFloat(rowCount - 1) * verticalSpacing)) / CGFloat(rowCount))

            VStack(spacing: headerSpacing) {
                HStack(spacing: 0) {
                    ForEach(weekdaySymbols, id: \.self) { symbol in
                        Text(symbol.uppercased())
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }

                LazyVGrid(columns: columns, spacing: verticalSpacing) {
                    ForEach(days) { day in
                        if day.isInDisplayedMonth {
                            NavigationLink {
                                CalendarDayDetailView(date: day.date, entry: entryProvider(day.date))
                            } label: {
                                CalendarDayCell(day: day, height: rowHeight)
                            }
                            .buttonStyle(.plain)
                        } else {
                            CalendarDayCell(day: day, height: rowHeight)
                        }
                    }
                }
            }
            .padding(MoodiUI.cardPadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background {
            SectionCardBackground()
        }
    }
}
