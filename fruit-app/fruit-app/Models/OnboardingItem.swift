import SwiftUI

struct OnboardingItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let headline: String
    let image: String
    let gradientColors: [Color]

    init(fruit: Fruit) {
        self.title = fruit.title
        self.headline = fruit.headline
        self.image = fruit.image
        self.gradientColors = fruit.gradientColors
    }
}

