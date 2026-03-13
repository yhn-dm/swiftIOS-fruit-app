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
                        ZStack {
                            FruitRowView(fruit: fruit)

                            NavigationLink {
                                FruitDetailView(fruit: fruit)
                            } label: {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.vertical, 8)
            }
            .navigationTitle("Fruits")
            .navigationBarTitleDisplayMode(.large)
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

