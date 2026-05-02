//
//  TodaySheetDestination.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import Foundation

enum TodaySheetDestination: Identifiable {
    case mood
    case metric(TodayMetricKind)

    var id: String {
        switch self {
        case .mood:
            "mood"
        case .metric(let kind):
            "metric-\(kind.rawValue)"
        }
    }
}
