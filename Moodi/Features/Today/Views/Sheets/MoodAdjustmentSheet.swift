//
//  MoodAdjustmentSheet.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct MoodAdjustmentSheet: View {
    @Environment(\.dismiss) private var dismiss

    let model: TodayViewModel

    @State private var selection: TodayMood

    init(model: TodayViewModel) {
        self.model = model
        _selection = State(initialValue: model.displayedMood ?? .neutral)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Choose the mood that fits best for today.")
                    .font(.body)
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    ForEach(TodayMood.allCases) { mood in
                        MoodSelectionButton(
                            mood: mood,
                            isSelected: selection == mood,
                            action: { selection = mood }
                        )
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(MoodiUI.screenPadding)
            .navigationTitle("Adjust today's mood")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done", action: saveAndDismiss)
                        .bold()
                }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(.ultraThinMaterial)
        .presentationCornerRadius(32)
    }

    private func saveAndDismiss() {
        model.chooseMood(selection)
        dismiss()
    }
}
