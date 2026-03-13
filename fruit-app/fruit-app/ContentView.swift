import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    @State private var hasStarted: Bool = false

    var body: some View {
        Group {
            if hasStarted || settingsViewModel.showOnboardingAgain == false {
                FruitListView()
            } else {
                OnboardingSliderView(
                    fruits: onboardingViewModel.fruits,
                    currentIndex: $onboardingViewModel.currentIndex,
                    startAction: {
                        onboardingViewModel.didTapStart(settingsViewModel: settingsViewModel)
                        hasStarted = true
                    }
                )
            }
        }
        .onAppear {
            hasStarted = settingsViewModel.showOnboardingAgain == false
        }
    }
}

private struct OnboardingSliderView: View {
    let fruits: [Fruit]
    @Binding var currentIndex: Int
    let startAction: () -> Void

    var body: some View {
        ZStack {
            if let currentFruit = fruits[safe: currentIndex] ?? fruits.first {
                LinearGradient(
                    colors: currentFruit.gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer(minLength: 40)

                    Image(currentFruit.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 280)
                        .shadow(radius: 16)

                    VStack(spacing: 12) {
                        Text(currentFruit.title)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        Text(currentFruit.headline)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }

                    Spacer()

                    VStack(spacing: 16) {
                        Button(action: startAction) {
                            HStack(spacing: 8) {
                                Text("Start")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 14)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                            )
                        }

                        HStack(spacing: 8) {
                            ForEach(fruits.indices, id: \.self) { index in
                                Circle()
                                    .fill(index == currentIndex ? Color.white : Color.white.opacity(0.4))
                                    .frame(
                                        width: index == currentIndex ? 8 : 6,
                                        height: index == currentIndex ? 8 : 6
                                    )
                            }
                        }
                    }

                    Spacer(minLength: 32)
                }
                .padding(.horizontal, 24)
            } else {
                ProgressView()
            }

            TabView(selection: $currentIndex) {
                ForEach(fruits.indices, id: \.self) { index in
                    Color.clear
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .opacity(0.01)
        }
    }
}

private extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    ContentView()
        .environmentObject(FruitListViewModel())
        .environmentObject(SettingsViewModel())
        .environmentObject(OnboardingViewModel())
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FruitListViewModel())
            .environmentObject(SettingsViewModel())
            .environmentObject(OnboardingViewModel())
    }
}
