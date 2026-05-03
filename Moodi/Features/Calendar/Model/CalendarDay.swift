//
//  CalendarDay.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation

struct CalendarDay: Identifiable, Hashable {
    let date: Date
    let isInDisplayedMonth: Bool
    let isToday: Bool
    let mood: TodayMood?

    var id: Date {
        date
    }

    var dayNumber: Int {
        Calendar.autoupdatingCurrent.component(.day, from: date)
    }

    var hasEntry: Bool {
        mood != nil
    }
}
