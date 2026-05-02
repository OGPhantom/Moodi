//
//  MoodSelectionButton.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct MoodSelectionButton: View {
    @Environment(\.colorScheme) private var colorScheme

    let mood: TodayMood
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(mood.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer(minLength: 0)

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(accentColor)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 22)
                    .fill(fillColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .strokeBorder(strokeColor, lineWidth: isSelected ? 1.5 : 1)
                    }
            }
        }
        .buttonStyle(.plain)
    }

    private var fillColor: Color {
        if isSelected {
            return accentColor.opacity(colorScheme == .dark ? 0.24 : 0.16)
        }

        switch colorScheme {
        case .light:
            return Color.primary.opacity(0.04)
        case .dark:
            return Color.white.opacity(0.05)
        @unknown default:
            return Color.primary.opacity(0.04)
        }
    }

    private var strokeColor: Color {
        if isSelected {
            return accentColor.opacity(colorScheme == .dark ? 0.72 : 0.42)
        }

        switch colorScheme {
        case .light:
            return Color.black.opacity(0.06)
        case .dark:
            return Color.white.opacity(0.08)
        @unknown default:
            return Color.black.opacity(0.06)
        }
    }

    private var accentColor: Color {
        switch mood {
        case .sad:
            Color(red: 0.42, green: 0.42, blue: 0.82)
        case .neutral:
            Color(red: 0.48, green: 0.52, blue: 0.90)
        case .happy:
            Color(red: 0.74, green: 0.52, blue: 0.78)
        }
    }
}
