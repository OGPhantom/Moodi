//
//  ActivityMetricEditorControl.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct ActivityMetricEditorControl: View {
    @Binding var value: Double

    var body: some View {
        Picker("Activity minutes", selection: $value) {
            ForEach(TodayMetricKind.activity.pickerValues, id: \.self) { item in
                Text(TodayMetricKind.activity.formattedPickerLabel(item))
                    .tag(item)
            }
        }
        .pickerStyle(.wheel)
    }
}
