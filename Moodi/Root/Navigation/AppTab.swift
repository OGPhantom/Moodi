//
//  AppTab.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import Foundation

enum AppTab: String, CaseIterable, Identifiable {
    case today
    case calendar
    case analytics
    case settings

    var id: String {
        rawValue
    }

    var systemImage: String {
        switch self {
        case .today:
            "sparkles.rectangle.stack.fill"
        case .calendar:
            "calendar"
        case .analytics:
            "chart.xyaxis.line"
        case .settings:
            "gearshape"
        }
    }
}
