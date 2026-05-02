//
//  SettingsView.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Data Sources") {
                Button("Health Access", systemImage: "heart.text.square") {
                }

                Button("Screen Time Access", systemImage: "hourglass") {
                }

                Text("Manual input is the only active source in the MVP. Screen Time integration is intentionally deferred.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section("Privacy") {
                LabeledContent("Processing") {
                    Text("On-device")
                }

                LabeledContent("Cloud Services") {
                    Text("Not used")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
