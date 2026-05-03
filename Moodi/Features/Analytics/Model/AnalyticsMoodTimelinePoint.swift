//
//  AnalyticsMoodTimelinePoint.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation

struct AnalyticsMoodTimelinePoint: Identifiable {
    let date: Date
    let mood: TodayMood?

    var id: Date {
        date
    }
}
