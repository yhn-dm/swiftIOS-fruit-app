import Foundation
import SwiftUI

final class FruitListViewModel: ObservableObject {
    @Published private(set) var fruits: [Fruit] = []

    init() {
        load()
    }

    func load() {
        do {
            fruits = try FruitDataService.shared.loadFruits()
        } catch {
            // En cas de souci de chargement, on fournit au moins une liste vide.
            fruits = []
        }
    }
}

