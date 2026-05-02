//
//  CardBackground.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

struct CardBackground: View {
    let cornerRadius: CGFloat
    let gradientColors: [Color]
    let primaryGlowColor: Color
    let secondaryGlowColor: Color
    let strokeColor: Color

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(alignment: .topTrailing) {
                Circle()
                    .fill(primaryGlowColor)
                    .frame(width: 108, height: 108)
                    .blur(radius: 26)
                    .offset(x: 28, y: -24)
                    .accessibilityHidden(true)
            }
            .overlay(alignment: .bottomLeading) {
                Circle()
                    .fill(secondaryGlowColor)
                    .frame(width: 88, height: 88)
                    .blur(radius: 24)
                    .offset(x: -18, y: 22)
                    .accessibilityHidden(true)
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(strokeColor, lineWidth: 1)
            }
    }
}
