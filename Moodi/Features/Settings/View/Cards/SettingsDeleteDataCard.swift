//
//  SettingsDeleteDataCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SettingsDeleteDataCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let action: () -> Void

    var body: some View {
        SettingsSectionCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Delete All Data")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.primary)

                Button(role: .destructive, action: action) {
                    HStack(spacing: 12) {
                        Image(systemName: "trash.fill")
                            .font(.headline)

                        Text("Delete Saved History")
                            .font(.headline)

                        Spacer(minLength: 0)

                        Image(systemName: "arrow.right")
                            .font(.subheadline.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(deleteButtonFill, in: RoundedRectangle(cornerRadius: 18))
                    .overlay {
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(Color.white.opacity(colorScheme == .dark ? 0.10 : 0.18), lineWidth: 1)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var deleteButtonFill: LinearGradient {
        let colors: [Color]

        switch colorScheme {
        case .light:
            colors = [
                Color(red: 0.93, green: 0.28, blue: 0.36),
                Color(red: 0.84, green: 0.18, blue: 0.31)
            ]
        case .dark:
            colors = [
                Color(red: 0.72, green: 0.18, blue: 0.28),
                Color(red: 0.58, green: 0.12, blue: 0.22)
            ]
        @unknown default:
            colors = [
                Color(red: 0.93, green: 0.28, blue: 0.36),
                Color(red: 0.84, green: 0.18, blue: 0.31)
            ]
        }

        return LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
