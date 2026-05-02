//
//  MoodiPalette.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

enum MoodiPalette {
    static let accent = Color(red: 0.40, green: 0.45, blue: 0.92)

    static func sectionCardFill(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.72)
        case .dark:
            Color.white.opacity(0.06)
        @unknown default:
            Color.white.opacity(0.72)
        }
    }

    static func sectionCardStroke(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.48)
        case .dark:
            Color.white.opacity(0.08)
        @unknown default:
            Color.white.opacity(0.48)
        }
    }
}
