//
//  ScreenTimeMetricEditorControl.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct ScreenTimeMetricEditorControl: View {
    @Binding var value: Double

    var body: some View {
        Picker("Screen time", selection: $value) {
            ForEach(TodayMetricKind.screenTime.pickerValues, id: \.self) { item in
                Text(TodayMetricKind.screenTime.formattedPickerLabel(item))
                    .tag(item)
            }
        }
        .pickerStyle(.wheel)
    }
}
