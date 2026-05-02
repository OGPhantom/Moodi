//
//  SettingsView.swift
//  Moodi
//
//  Created by Никита Сторчай on 02.05.2026.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext

    @AppStorage(AppAppearance.storageKey) private var appearanceRawValue = AppAppearance.system.rawValue
    @State private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: MoodiUI.sectionSpacing) {
                    SettingsPrivacyCard()
                    appearanceSection
                    dataSourcesSection
//                    SettingsPrivacyCard()
                    deleteDataSection
                }
                .padding(.horizontal, MoodiUI.screenPadding)
                .padding(.top, MoodiUI.topSpacing)
                .padding(.bottom, MoodiUI.bottomSpacing)
            }
            .navigationTitle("Settings")
            .scrollIndicators(.hidden)
            .background {
                AppBackground()
            }
            .task {
                viewModel.setAppearance(storedAppearance)
            }
            .onChange(of: viewModel.selectedAppearance) { _, newValue in
                appearanceRawValue = newValue.rawValue
            }
            .alert("Delete all data?", isPresented: deleteConfirmationBinding) {
                Button("Delete All Data", role: .destructive, action: deleteAllData)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will remove all saved moods and daily behavior metrics from this device.")
            }
        }
    }

    private var storedAppearance: AppAppearance {
        AppAppearance(rawValue: appearanceRawValue) ?? .system
    }

    private var deleteConfirmationBinding: Binding<Bool> {
        Binding(
            get: { viewModel.isDeleteAlertPresented },
            set: { viewModel.isDeleteAlertPresented = $0 }
        )
    }

    private var appearanceSection: some View {
            SettingsSectionCard {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Theme")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.primary)

                    HStack(spacing: 6) {
                        ForEach(AppAppearance.allCases) { appearance in
                            themeSegment(appearance)
                        }
                    }
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.primary.opacity(0.05))
                    )
                }
            }
    }

    private var dataSourcesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SettingsDataSourcesCard(
                isHealthAccessHighlighted: viewModel.isHealthAccessHighlighted,
                isScreenTimeHighlighted: viewModel.isScreenTimeHighlighted,
                toggleHealthAccess: toggleHealthAccess,
                toggleScreenTime: toggleScreenTime
            )
        }
    }

    private var deleteDataSection: some View {
        SettingsDeleteDataCard(action: showDeleteConfirmation)
    }

    private func toggleHealthAccess() {
        viewModel.toggleHealthAccessHighlight()
    }

    private func toggleScreenTime() {
        viewModel.toggleScreenTimeHighlight()
    }

    private func showDeleteConfirmation() {
        viewModel.presentDeleteAlert()
    }

    private func deleteAllData() {
        viewModel.deleteAllData(using: modelContext)
    }

    private func themeSegment(_ appearance: AppAppearance) -> some View {
        let isSelected = viewModel.selectedAppearance == appearance

        return Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.setAppearance(appearance)
            }
        }) {
            HStack(spacing: 6) {
                Image(systemName: appearance.icon)
                    .font(.system(size: 13, weight: .semibold))

                Text(appearance.title)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(isSelected ? .white : .primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        isSelected
                        ? MoodiPalette.accent
                        : Color.clear
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .modelContainer(for: DailyMoodEntry.self, inMemory: true)
}
