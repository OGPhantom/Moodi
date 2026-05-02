//
//  TodayView.swift
//  Moodi
//
//  Created by OpenAI on 02.05.2026.
//

import SwiftUI

@MainActor
struct TodayView: View {
    @State private var model: TodayViewModel
    @State private var presentedSheet: TodaySheetDestination?

    init(model: TodayViewModel? = nil) {
        _model = State(initialValue: model ?? TodayViewModel())
    }

    var body: some View {
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
        .toolbar(.hidden, for: .navigationBar)
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
}

#Preview("Predicted") {
    NavigationStack {
        TodayView(model: .previewFilled())
    }
}

#Preview("Adjusted") {
    NavigationStack {
        TodayView(model: .previewAdjusted())
    }
}
