//
//  SettingsSectionCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct SettingsSectionCard<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .padding(MoodiUI.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            SectionCardBackground()
        }
    }
}
