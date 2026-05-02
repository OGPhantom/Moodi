//
//  StepsMetricEditorControl.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct StepsMetricEditorControl: View {
    @Binding var value: Double

    var body: some View {
        Picker("Steps", selection: $value) {
            ForEach(TodayMetricKind.steps.pickerValues, id: \.self) { item in
                Text(TodayMetricKind.steps.formattedPickerLabel(item))
                    .tag(item)
            }
        }
        .pickerStyle(.wheel)
    }
}
