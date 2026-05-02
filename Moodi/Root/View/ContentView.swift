//
//  ContentView.swift
//  Moodi
//
//  Created by Никита Сторчай on 28.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .today

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Today", systemImage: AppTab.today.systemImage, value: .today) {
                NavigationStack {
                    TodayView()
                }
            }

            Tab("Calendar", systemImage: AppTab.calendar.systemImage, value: .calendar) {
                NavigationStack {
                    CalendarView()
                }
            }

            Tab("Analytics", systemImage: AppTab.analytics.systemImage, value: .analytics) {
                NavigationStack {
                    AnalyticsView()
                }
            }

            Tab("Settings", systemImage: AppTab.settings.systemImage, value: .settings) {
                NavigationStack {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
