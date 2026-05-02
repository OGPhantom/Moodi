//
//  CalendarView.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ContentUnavailableView(
            "Calendar",
            systemImage: "calendar",
            description: Text("Daily mood history will land here once today entries are flowing.")
        )
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
