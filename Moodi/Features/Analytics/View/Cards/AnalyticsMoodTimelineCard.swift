//
//  AnalyticsMoodTimelineCard.swift
//  Moodi
//
//  Created by Никита Сторчай on 03.05.2026.
//

import SwiftUI

struct AnalyticsMoodTimelineCard: View {
    @Environment(\.colorScheme) private var colorScheme

    let points: [AnalyticsMoodTimelinePoint]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Mood over time")
                .font(.title3.bold())
                .foregroundStyle(.primary)

            GeometryReader { proxy in
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        let metrics = layoutMetrics(availableWidth: proxy.size.width)

                        HStack(alignment: .bottom, spacing: metrics.spacing) {
                            ForEach(points) { point in
                                Capsule()
                                    .fill(capsuleFill(for: point))
                                    .frame(width: metrics.capsuleWidth, height: 116)
                                    .overlay {
                                        Capsule()
                                            .strokeBorder(capsuleStroke(for: point), lineWidth: point.mood == nil ? 1 : 0)
                                    }
                                    .id(point.id)
                            }
                        }
                        .padding(.vertical, 2)
                        .frame(width: metrics.contentWidth, alignment: .leading)
                    }
                    .scrollIndicators(.hidden)
                    .onAppear {
                        scrollToLatest(in: scrollProxy)
                    }
                    .onChange(of: points.count) { _, _ in
                        scrollToLatest(in: scrollProxy)
                    }
                }
            }
            .frame(height: 120)

            HStack {
                Text(points.first?.date.formatted(.dateTime.month(.abbreviated).day()) ?? "--")
                Spacer(minLength: 0)
                Text(points.last?.date.formatted(.dateTime.month(.abbreviated).day()) ?? "--")
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        .padding(MoodiUI.cardPadding)
        .background {
            SectionCardBackground()
        }
    }

    private func capsuleFill(for point: AnalyticsMoodTimelinePoint) -> some ShapeStyle {
        if let mood = point.mood {
            return AnyShapeStyle(
                LinearGradient(
                    colors: mood.calendarGradientColors(for: colorScheme),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }

        return AnyShapeStyle(Color.primary.opacity(colorScheme == .dark ? 0.08 : 0.06))
    }

    private func capsuleStroke(for point: AnalyticsMoodTimelinePoint) -> Color {
        point.mood == nil
        ? Color.primary.opacity(colorScheme == .dark ? 0.10 : 0.08)
        : .clear
    }

    private func layoutMetrics(availableWidth: CGFloat) -> (contentWidth: CGFloat, capsuleWidth: CGFloat, spacing: CGFloat) {
        let spacing: CGFloat = 6
        let pointCount = max(points.count, 1)
        let contentWidth = max(availableWidth, CGFloat(pointCount) * 12)
        let capsuleWidth: CGFloat

        if pointCount <= 10 {
            capsuleWidth = max(10, (contentWidth - CGFloat(pointCount - 1) * spacing) / CGFloat(pointCount))
        } else {
            capsuleWidth = 6
        }

        return (contentWidth, capsuleWidth, spacing)
    }

    private func scrollToLatest(in scrollProxy: ScrollViewProxy) {
        guard points.count > 14, let lastID = points.last?.id else {
            return
        }

        scrollProxy.scrollTo(lastID, anchor: .trailing)
    }
}
