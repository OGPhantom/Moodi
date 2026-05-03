//
//  CalendarMonthHeader.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct CalendarMonthHeader: View {
    let monthTitle: String
    let previousAction: () -> Void
    let nextAction: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(monthTitle)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.primary)
            }

            Spacer(minLength: 0)

            HStack(spacing: 10) {
                monthButton(systemImage: "chevron.left", action: previousAction)
                monthButton(systemImage: "chevron.right", action: nextAction)
            }
        }
    }

    private func monthButton(systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(width: 42, height: 42)
                .background {
                    SectionCardBackground()
                }
                .contentShape(.rect(cornerRadius: 18))
        }
        .buttonStyle(.plain)
    }
}
