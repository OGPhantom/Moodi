//
//  AnalyticsView.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        ContentUnavailableView(
            "Analytics",
            systemImage: "chart.xyaxis.line",
            description: Text("Trends and longer-range patterns will appear here after enough daily data is collected.")
        )
        .navigationTitle("Analytics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AnalyticsView()
    }
}
