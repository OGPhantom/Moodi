//
//  SettingsViewModel.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class SettingsViewModel {
    var selectedAppearance: AppAppearance
    var isDeleteAlertPresented = false
    var isHealthAccessHighlighted = true
    var isScreenTimeHighlighted = false

    init(selectedAppearance: AppAppearance = .system) {
        self.selectedAppearance = selectedAppearance
    }

    func setAppearance(_ appearance: AppAppearance) {
        selectedAppearance = appearance
    }

    func toggleHealthAccessHighlight() {
        isHealthAccessHighlighted.toggle()
    }

    func toggleScreenTimeHighlight() {
        isScreenTimeHighlighted.toggle()
    }

    func presentDeleteAlert() {
        isDeleteAlertPresented = true
    }

    func deleteAllData(using modelContext: ModelContext) {
        do {
            let entries = try modelContext.fetch(FetchDescriptor<DailyMoodEntry>())
            for entry in entries {
                modelContext.delete(entry)
            }
            try modelContext.save()
            NotificationCenter.default.post(name: .moodiDidDeleteAllData, object: nil)
        } catch {
            assertionFailure("Failed to delete all daily mood entries: \(error)")
        }
    }
}
