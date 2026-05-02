//
//  SectionCardBackground.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SectionCardBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
            .fill(MoodiPalette.sectionCardFill(for: colorScheme))
            .overlay {
                RoundedRectangle(cornerRadius: MoodiUI.cardCornerRadius)
                    .strokeBorder(MoodiPalette.sectionCardStroke(for: colorScheme), lineWidth: 1)
            }
    }
}
