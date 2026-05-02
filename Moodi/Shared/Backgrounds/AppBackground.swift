//
//  AppBackground.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct AppBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            LinearGradient(
                colors: baseGradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(accentColor.opacity(colorScheme == .dark ? 0.32 : 0.28))
                .frame(width: 320, height: 320)
                .blur(radius: 84)
                .offset(x: 160, y: -220)

            Circle()
                .fill(secondaryAccentColor.opacity(colorScheme == .dark ? 0.24 : 0.20))
                .frame(width: 260, height: 260)
                .blur(radius: 92)
                .offset(x: -160, y: -40)
        }
        .ignoresSafeArea()
    }

    private var baseGradientColors: [Color] {
        switch colorScheme {
        case .light:
            [
                Color(red: 0.96, green: 0.96, blue: 0.99),
                Color(red: 0.93, green: 0.94, blue: 0.99),
                Color(red: 0.90, green: 0.92, blue: 0.98)
            ]
        case .dark:
            [
                Color(red: 0.06, green: 0.07, blue: 0.11),
                Color(red: 0.09, green: 0.10, blue: 0.16),
                Color(red: 0.11, green: 0.12, blue: 0.19)
            ]
        @unknown default:
            [
                Color(red: 0.96, green: 0.96, blue: 0.99),
                Color(red: 0.93, green: 0.94, blue: 0.99),
                Color(red: 0.90, green: 0.92, blue: 0.98)
            ]
        }
    }

    private var accentColor: Color {
        Color(red: 0.44, green: 0.38, blue: 0.82)
    }

    private var secondaryAccentColor: Color {
        Color(red: 0.52, green: 0.62, blue: 0.96)
    }
}
