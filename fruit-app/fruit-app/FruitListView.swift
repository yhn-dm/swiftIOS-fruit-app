//
// Cette vue rassemble nos fruits en une liste claire et appétissante.
//

import SwiftUI

struct FruitListView: View {
    @EnvironmentObject private var listViewModel: FruitListViewModel
    @EnvironmentObject private var settingsViewModel: SettingsViewModel

    @State private var showSettings: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(listViewModel.fruits) { fruit in
                        NavigationLink {
                            FruitDetailView(fruit: fruit)
                        } label: {
                            FruitRowView(fruit: fruit)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .navigationTitle("Fruits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .imageScale(.medium)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .environmentObject(settingsViewModel)
            }
        }
    }
}

#Preview {
    FruitListView()
        .environmentObject(FruitListViewModel())
        .environmentObject(SettingsViewModel())
}

