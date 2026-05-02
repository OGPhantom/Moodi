//
//  TodayMetricKind.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import Foundation

enum TodayMetricKind: String, CaseIterable, Identifiable {
    case sleep
    case activity
    case screenTime
    case steps

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .sleep:
            "Sleep"
        case .activity:
            "Activity"
        case .screenTime:
            "Screen Time"
        case .steps:
            "Steps"
        }
    }

    var systemImage: String {
        switch self {
        case .sleep:
            "bed.double.fill"
        case .activity:
            "figure.run"
        case .screenTime:
            "iphone"
        case .steps:
            "shoeprints.fill"
        }
    }

    var editorTitle: String {
        "Edit \(title)"
    }

    var defaultValue: Double {
        switch self {
        case .sleep:
            7.5
        case .activity:
            45
        case .screenTime:
            4
        case .steps:
            7_500
        }
    }

    var pickerValues: [Double] {
        switch self {
        case .sleep:
            Array(stride(from: 0.0, through: 14.0, by: 0.5))
        case .activity:
            Array(stride(from: 0.0, through: 240.0, by: 5.0))
        case .screenTime:
            Array(stride(from: 0.0, through: 16.0, by: 0.25))
        case .steps:
            Array(stride(from: 0.0, through: 40_000.0, by: 500.0))
        }
    }

    func formattedTileValue(_ value: Double?) -> String {
        guard let value else {
            return "--"
        }

        switch self {
        case .activity:
            return Int(value.rounded()).formatted()
        case .sleep, .screenTime:
            return formattedHoursAndMinutes(value)
        case .steps:
            return Int(value.rounded()).formatted()
        }
    }

    func formattedTileUnit(_ value: Double?) -> String {
        guard value != nil else {
            return "Add value"
        }

        switch self {
        case .sleep:
            return "hr"
        case .activity:
            return "min"
        case .screenTime:
            return "hr"
        case .steps:
            return "steps"
        }
    }

    func formattedEditorValue(_ value: Double) -> String {
        switch self {
        case .activity:
            "\(Int(value.rounded()).formatted()) min"
        case .sleep, .screenTime:
            formattedHoursAndMinutes(value)
        case .steps:
            "\(Int(value.rounded()).formatted()) steps"
        }
    }

    func formattedPickerLabel(_ value: Double) -> String {
        switch self {
        case .activity:
            "\(Int(value.rounded()).formatted()) min"
        case .sleep, .screenTime:
            formattedHoursAndMinutes(value)
        case .steps:
            Int(value.rounded()).formatted()
        }
    }

    private func formattedHoursAndMinutes(_ value: Double) -> String {
        let totalMinutes = Int((value * 60).rounded())
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60

        if minutes == 0 {
            return "\(hours)h"
        }

        return "\(hours)h \(minutes)m"
    }
}
