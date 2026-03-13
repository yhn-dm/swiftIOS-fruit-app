//
// Vue-modèle pour piloter sereinement le slider d’accueil.
//

import Foundation
import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @Published private(set) var fruits: [Fruit] = []
    @Published var currentIndex: Int = 0

    init() {
        load()
    }

    func load() {
        do {
            fruits = try FruitDataService.shared.loadFruits()
        } catch {
            fruits = []
        }
    }

    func didTapStart(settingsViewModel: SettingsViewModel) {
        settingsViewModel.showOnboardingAgain = false
    }
}

