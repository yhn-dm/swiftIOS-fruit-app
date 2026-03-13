import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isOnboarding") private var isOnboarding: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    fructusSection
                    customizationSection
                    applicationSection
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.semibold))
                    }
                    .accessibilityLabel("Close")
                }
            }
        }
    }

    private var fructusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 52, height: 52)

                    Image(systemName: "leaf.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Fructus")
                        .font(.headline)
                    Text("Most fruits are naturally low in fat, sodium and calories, yet full of vitamins and useful nutrients.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }

    private var customizationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "paintbrush.fill")
                    .foregroundStyle(.pink)
                Text("Customization")
                    .font(.headline)
                Spacer()
            }

            Text("If you wish, you can restart the onboarding by toggling the switch below. The next time the app launches, you will see the welcome screens again.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Toggle(isOn: $isOnboarding) {
                Text("Restart onboarding")
                    .font(.subheadline.weight(.semibold))
            }
            .padding(.top, 4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }

    private var applicationSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Application")
                .font(.headline)

            settingsRow(title: "Developer", value: "John / Jane")
            settingsRow(title: "Designer", value: "Robert Petras")
            settingsRow(title: "Compatibility", value: "iOS 14+")
            settingsRow(title: "Website", value: "swiftui-masterclass.com")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }

    private func settingsRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
        .font(.subheadline)
        .padding(.vertical, 4)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(Color.secondary.opacity(0.15)),
            alignment: .bottom
        )
    }
}

#Preview {
    SettingsView()
}

