import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var items: [OnboardingItem] = []

    init() {
        let fruits = FruitDataService.loadFruits()
        let selectedFruits = Array(fruits.prefix(5))
        self.items = selectedFruits.map(OnboardingItem.init(fruit:))
    }
}

