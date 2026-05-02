//
//  TodayView.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI
import SwiftData

@MainActor
struct TodayView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var model: TodayViewModel
    @State private var presentedSheet: TodaySheetDestination?

    init(model: TodayViewModel? = nil) {
        _model = State(initialValue: model ?? TodayViewModel())
    }

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: MoodiUI.sectionSpacing) {
                    TodayHeaderView(date: model.currentDate)
                    TodayHeroCard(state: model.heroState, action: openMoodAdjustment)
                    TodayInputsCard(model: model, action: presentMetricEditor)
                }
                .padding(.horizontal, MoodiUI.screenPadding)
                .padding(.top, MoodiUI.topSpacing)
                .padding(.bottom, MoodiUI.bottomSpacing)
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background {
                AppBackground()
            }
            .sheet(item: $presentedSheet) { destination in
                switch destination {
                case .mood:
                    MoodAdjustmentSheet(model: model)
                case .metric(let kind):
                    MetricEditorSheet(kind: kind, model: model)
                }
            }
            .task {
                model.configure(modelContext: modelContext)
            }
            .onReceive(NotificationCenter.default.publisher(for: .moodiDidDeleteAllData)) { _ in
                model.clearStoredState()
            }
        }
    }

    private func openMoodAdjustment() {
        presentedSheet = .mood
    }

    private func presentMetricEditor(_ kind: TodayMetricKind) {
        presentedSheet = .metric(kind)
    }
}

#Preview("Empty") {
    NavigationStack {
        TodayView()
    }
    .modelContainer(for: DailyMoodEntry.self, inMemory: true)
}

#Preview("Predicted") {
    NavigationStack {
        TodayView(model: .previewFilled())
    }
    .modelContainer(for: DailyMoodEntry.self, inMemory: true)
}

#Preview("Adjusted") {
    NavigationStack {
        TodayView(model: .previewAdjusted())
    }
    .modelContainer(for: DailyMoodEntry.self, inMemory: true)
}
