//
//  SleepMetricEditorControl.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SleepMetricEditorControl: View {
    @Binding var value: Double

    var body: some View {
        Picker("Sleep hours", selection: $value) {
            ForEach(TodayMetricKind.sleep.pickerValues, id: \.self) { item in
                Text(TodayMetricKind.sleep.formattedPickerLabel(item))
                    .tag(item)
            }
        }
        .pickerStyle(.wheel)
    }
}
