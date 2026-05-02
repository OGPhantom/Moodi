//
//  TodayHeroCard.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct TodayHeroCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let state: TodayHeroDisplayState
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 18) {

                Spacer(minLength: 0)

                VStack(alignment: .leading, spacing: 10) {
                    Text(state.eyebrow)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.76))
                    
                    Text(state.title)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 0)

                HStack(spacing: 10) {
                    Label(state.pillText, systemImage: state.pillSystemImage)
                        .font(.callout)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(pillBackground, in: Capsule())
                        .foregroundStyle(.white)

                    Spacer()

                    Image(systemName: "sparkles")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                }
            }
            .padding(MoodiUI.cardPadding)
            .frame(maxWidth: .infinity, minHeight: MoodiUI.heroMinHeight, alignment: .topLeading)
            .background {
                RoundedRectangle(cornerRadius: MoodiUI.heroCornerRadius)
                    .fill(backgroundGradient)
                    .overlay {
                        RoundedRectangle(cornerRadius: MoodiUI.heroCornerRadius)
                            .strokeBorder(Color.white.opacity(colorScheme == .dark ? 0.08 : 0.18), lineWidth: 1)
                    }
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(Color.white.opacity(colorScheme == .dark ? 0.12 : 0.16))
                            .frame(width: 160, height: 160)
                            .blur(radius: 36)
                            .offset(x: 48, y: -36)
                            .accessibilityHidden(true)
                    }
            }
            .contentShape(.rect(cornerRadius: MoodiUI.heroCornerRadius))
        }
        .buttonStyle(.plain)
        .allowsHitTesting(state.isInteractive)
        .accessibilityLabel(state.accessibilityLabel)
        .accessibilityHint(state.isInteractive ? "Double-tap to adjust today's mood." : "Add all four inputs to unlock mood adjustment.")
    }

    private var backgroundGradient: LinearGradient {
        let colors: [Color]

        switch state {
        case .predicted(let mood, _, _):
            colors = mood.heroGradientColors(for: colorScheme)
        case .empty:
            colors = emptyGradientColors
        case .unavailable:
            colors = unavailableGradientColors
        }

        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    private var pillBackground: Color {
        switch state {
        case .predicted(let mood, _, _):
            mood.pillFillColor(for: colorScheme)
        case .empty:
            Color.white.opacity(colorScheme == .dark ? 0.10 : 0.18)
        case .unavailable:
            Color.white.opacity(colorScheme == .dark ? 0.10 : 0.16)
        }
    }

    private var emptyGradientColors: [Color] {
        switch colorScheme {
        case .light:
            [
                Color(red: 0.32, green: 0.36, blue: 0.70),
                Color(red: 0.44, green: 0.47, blue: 0.76),
                Color(red: 0.62, green: 0.58, blue: 0.80)
            ]
        case .dark:
            [
                Color(red: 0.12, green: 0.15, blue: 0.30),
                Color(red: 0.21, green: 0.22, blue: 0.42),
                Color(red: 0.30, green: 0.28, blue: 0.46)
            ]
        @unknown default:
            [
                Color(red: 0.32, green: 0.36, blue: 0.70),
                Color(red: 0.44, green: 0.47, blue: 0.76),
                Color(red: 0.62, green: 0.58, blue: 0.80)
            ]
        }
    }

    private var unavailableGradientColors: [Color] {
        switch colorScheme {
        case .light:
            [
                Color(red: 0.31, green: 0.31, blue: 0.46),
                Color(red: 0.42, green: 0.39, blue: 0.54),
                Color(red: 0.58, green: 0.50, blue: 0.63)
            ]
        case .dark:
            [
                Color(red: 0.14, green: 0.14, blue: 0.20),
                Color(red: 0.23, green: 0.21, blue: 0.30),
                Color(red: 0.33, green: 0.28, blue: 0.38)
            ]
        @unknown default:
            [
                Color(red: 0.31, green: 0.31, blue: 0.46),
                Color(red: 0.42, green: 0.39, blue: 0.54),
                Color(red: 0.58, green: 0.50, blue: 0.63)
            ]
        }
    }
}
