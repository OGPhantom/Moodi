//
//  MoodiApp.swift
//  Moodi
//
//  Created by Никита Сторчай on 28.04.2026.
//

import SwiftUI
import SwiftData

@main
struct MoodiApp: App {
    @AppStorage(AppAppearance.storageKey) private var appearanceRawValue = AppAppearance.system.rawValue

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(selectedAppearance.colorScheme)
                .tint(MoodiPalette.accent)
        }
        .modelContainer(for: [DailyMoodEntry.self])
    }

    private var selectedAppearance: AppAppearance {
        AppAppearance(rawValue: appearanceRawValue) ?? .system
    }
}
