import Foundation

final class FruitListViewModel: ObservableObject {
    @Published var fruits: [Fruit] = []

    init() {
        load()
    }

    func load() {
        fruits = FruitDataService.loadFruits()
    }
}

