//
//  SettingsSourceButton.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SettingsSourceButton: View {
    @Environment(\.colorScheme) private var colorScheme

    let title: String
    let subtitle: String
    let systemImage: String
    let isActive: Bool
    let activeGradientColors: [Color]
    let primaryGlowColor: Color
    let secondaryGlowColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 14) {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(iconColor)
                    .frame(width: 42, height: 42)
                    .background(iconBackground, in: RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(titleColor)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(subtitleColor)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 108, alignment: .leading)
            .background(buttonBackground)
            .contentShape(.rect(cornerRadius: MoodiUI.cardCornerRadius))
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.34, dampingFraction: 0.82), value: isActive)
    }

    @ViewBuilder
    private var buttonBackground: some View {
        if isActive {
            CardBackground(
                cornerRadius: MoodiUI.cardCornerRadius,
                gradientColors: activeGradientColors,
                primaryGlowColor: primaryGlowColor,
                secondaryGlowColor: secondaryGlowColor,
                strokeColor: Color.white.opacity(colorScheme == .dark ? 0.16 : 0.58)
            )
        } else {
            RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                .fill(MoodiPalette.sectionCardFill(for: colorScheme))
                .overlay {
                    RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                        .fill(primaryGlowColor.opacity(colorScheme == .dark ? 0.12 : 0.08))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                        .strokeBorder(primaryGlowColor.opacity(colorScheme == .dark ? 0.55 : 0.34), lineWidth: 1.2)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                        .strokeBorder(Color.white.opacity(colorScheme == .dark ? 0.06 : 0.22), lineWidth: 0.5)
                }
                .shadow(color: primaryGlowColor.opacity(colorScheme == .dark ? 0.14 : 0.10), radius: 18, y: 10)
        }
    }

    private var iconBackground: Color {
        if isActive {
            return Color.white.opacity(colorScheme == .dark ? 0.12 : 0.20)
        }

        return primaryGlowColor.opacity(colorScheme == .dark ? 0.18 : 0.14)
    }

    private var iconColor: Color {
        if isActive {
            return .white
        }

        return colorScheme == .dark ? Color.white.opacity(0.82) : .primary
    }

    private var titleColor: Color {
        if isActive {
            return .white
        }

        return .primary
    }

    private var subtitleColor: Color {
        if isActive {
            return Color.white.opacity(0.84)
        }

        return colorScheme == .dark ? Color.white.opacity(0.70) : Color.primary.opacity(0.60)
    }
}
