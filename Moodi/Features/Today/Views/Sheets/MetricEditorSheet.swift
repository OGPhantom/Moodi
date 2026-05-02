//
//  MetricEditorSheet.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct MetricEditorSheet: View {
    @Environment(\.dismiss) private var dismiss

    let kind: TodayMetricKind
    let model: TodayViewModel

    @State private var draftValue: Double

    init(kind: TodayMetricKind, model: TodayViewModel) {
        self.kind = kind
        self.model = model
        _draftValue = State(initialValue: model.value(for: kind) ?? kind.defaultValue)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 18) {
                Label(kind.title, systemImage: kind.systemImage)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(kind.formattedEditorValue(draftValue))
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .foregroundStyle(.primary)

                Group {
                    switch kind {
                    case .sleep:
                        SleepMetricEditorControl(value: $draftValue)
                    case .activity:
                        ActivityMetricEditorControl(value: $draftValue)
                    case .screenTime:
                        ScreenTimeMetricEditorControl(value: $draftValue)
                    case .steps:
                        StepsMetricEditorControl(value: $draftValue)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(MoodiUI.screenPadding)
            .navigationTitle(kind.editorTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: draftValue) { _, newValue in
                if model.value(for: kind) != newValue {
                    model.update(kind, to: newValue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done", action: saveAndDismiss)
                        .bold()
                }
            }
        }
        .presentationDetents([.fraction(0.42), .medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(.ultraThinMaterial)
        .presentationCornerRadius(32)
    }

    private func saveAndDismiss() {
        if model.value(for: kind) != draftValue {
            model.update(kind, to: draftValue)
        }
        dismiss()
    }
}
