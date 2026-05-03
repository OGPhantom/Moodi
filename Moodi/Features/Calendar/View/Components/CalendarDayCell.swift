//
//  CalendarDayCell.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct CalendarDayCell: View {
    @Environment(\.colorScheme) private var colorScheme

    let day: CalendarDay
    let height: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(cellFill)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(cellStroke, lineWidth: cellStrokeWidth)
                }

            if day.isInDisplayedMonth {
                ZStack {
                    VStack(alignment: .leading) {
                        HStack {
                            dayBadge
                            Spacer(minLength: 0)
                        }

                        Spacer(minLength: 0)
                    }

                    if day.isToday {
                        VStack {
                            Spacer(minLength: 0)

                            Circle()
                                .fill(todayDotFill)
                                .frame(width: todayDotSize, height: todayDotSize)
                                .overlay {
                                    Circle()
                                        .strokeBorder(todayDotStroke, lineWidth: todayDotStrokeWidth)
                                }
                                .shadow(
                                    color: todayDotShadow,
                                    radius: colorScheme == .light ? 8 : 4,
                                    y: 1
                                )
                                .padding(.bottom, 12)
                        }
                    }
                }
                .padding(10)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .contentShape(.rect(cornerRadius: 18))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
    }

    private var cellFill: some ShapeStyle {
        guard day.isInDisplayedMonth else {
            return AnyShapeStyle(Color.clear)
        }

        guard day.hasEntry else {
            return AnyShapeStyle(Color.clear)
        }

        guard let mood = day.mood else {
            return AnyShapeStyle(Color.clear)
        }

        return AnyShapeStyle(
            LinearGradient(
                colors: mood.calendarGradientColors(for: colorScheme),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    private var cellStroke: Color {
        guard day.isInDisplayedMonth else {
            return .clear
        }

        guard day.hasEntry else {
            return .clear
        }

        if day.hasEntry {
            return Color.white.opacity(colorScheme == .dark ? 0.12 : 0.32)
        }

        return colorScheme == .dark
        ? Color.white.opacity(0.10)
        : Color.white.opacity(0.68)
    }

    private var cellStrokeWidth: CGFloat {
        return day.isInDisplayedMonth ? 1 : 0
    }

    private var dayNumberColor: Color {
        if day.hasEntry {
            return .white
        }

        return colorScheme == .dark
        ? Color.white.opacity(0.50)
        : Color.primary.opacity(0.58)
    }

    private var dayBadge: some View {
        Text(day.dayNumber.formatted())
            .font(.subheadline.weight(day.hasEntry || day.isToday ? .semibold : .medium))
            .foregroundStyle(dayNumberColor)
            .frame(width: 32, height: 32)
            .background(dayBadgeBackground, in: Circle())
            .overlay {
                Circle()
                    .strokeBorder(dayBadgeStroke, lineWidth: dayBadgeStrokeWidth)
            }
    }

    private var dayBadgeBackground: some ShapeStyle {
        if day.hasEntry {
            return AnyShapeStyle(Color.white.opacity(colorScheme == .dark ? 0.16 : 0.22))
        }

        return AnyShapeStyle(
            colorScheme == .dark
            ? Color.white.opacity(0.10)
            : Color.white.opacity(0.90)
        )
    }

    private var dayBadgeStroke: Color {
        guard !day.hasEntry else {
            return .clear
        }

        return colorScheme == .dark
        ? Color.white.opacity(0.08)
        : Color.gray.opacity(0.08)
    }

    private var dayBadgeStrokeWidth: CGFloat {
        day.hasEntry ? 0 : 1
    }

    private var todayDotFill: Color {
        day.hasEntry ? .white : MoodiPalette.accent
    }

    private var todayDotStroke: Color {
        if colorScheme == .light && !day.hasEntry {
            return Color.white.opacity(0.95)
        }

        return .clear
    }

    private var todayDotStrokeWidth: CGFloat {
        colorScheme == .light && !day.hasEntry ? 1.5 : 0
    }

    private var todayDotShadow: Color {
        if colorScheme == .light && !day.hasEntry {
            return MoodiPalette.accent.opacity(0.26)
        }

        return MoodiPalette.accent.opacity(colorScheme == .dark ? 0.18 : 0.14)
    }

    private var todayDotSize: CGFloat {
        colorScheme == .light && !day.hasEntry ? 8 : 7
    }

    private var accessibilityLabel: String {
        guard day.isInDisplayedMonth else {
            return ""
        }

        let dateText = day.date.formatted(.dateTime.month(.wide).day())

        if let mood = day.mood {
            return "\(dateText), \(mood.title)"
        }

        return "\(dateText), no data"
    }
}
