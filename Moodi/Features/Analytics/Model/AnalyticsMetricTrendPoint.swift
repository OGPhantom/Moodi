//
//  AnalyticsMetricTrendPoint.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import Foundation

struct AnalyticsMetricTrendPoint: Identifiable {
    let date: Date
    let value: Double

    var id: Date {
        date
    }
}
