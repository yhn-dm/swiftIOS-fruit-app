//
// Petit point d’entrée qui assemble tranquillement nos vues et modèles.
//

import SwiftUI

@main
struct fruit_appApp: App {
    @StateObject private var listViewModel = FruitListViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(listViewModel)
                .environmentObject(settingsViewModel)
                .environmentObject(onboardingViewModel)
        }
    }
}

