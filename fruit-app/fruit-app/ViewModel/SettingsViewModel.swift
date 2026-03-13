//
// Petit vue-modèle pour garder les préférences de l’app au chaud.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var showOnboardingAgain: Bool {
        didSet {
            UserDefaults.standard.set(showOnboardingAgain, forKey: Self.onboardingKey)
        }
    }

    private static let onboardingKey = "showOnboardingAgain"

    init() {
        let stored = UserDefaults.standard.object(forKey: Self.onboardingKey) as? Bool
        self.showOnboardingAgain = stored ?? true
    }
}

