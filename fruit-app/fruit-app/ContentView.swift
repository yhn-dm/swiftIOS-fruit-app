import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarding") private var isOnboarding: Bool = true

    var body: some View {
        Group {
            if isOnboarding {
                OnboardingView()
            } else {
                FruitListView()
            }
        }
    }
}

#Preview {
    ContentView()
}

