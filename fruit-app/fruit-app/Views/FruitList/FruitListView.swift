import SwiftUI

struct FruitListView: View {
    @StateObject private var viewModel = FruitListViewModel()
    @State private var isShowingSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                List {
                    ForEach(viewModel.fruits) { fruit in
                        NavigationLink {
                            FruitDetailView(fruit: fruit)
                        } label: {
                            FruitRowView(fruit: fruit)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Fruits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingSettings = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Settings")
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    FruitListView()
}

