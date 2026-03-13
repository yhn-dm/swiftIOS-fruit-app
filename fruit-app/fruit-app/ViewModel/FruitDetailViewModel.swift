//
// Vue-modèle pour raconter l'histoire détaillée de chaque fruit.
//

import Foundation
import SwiftUI

final class FruitDetailViewModel: ObservableObject {
    let fruit: Fruit

    init(fruit: Fruit) {
        self.fruit = fruit
    }

    var title: String { fruit.title }
    var headline: String { fruit.headline }
    var imageName: String { fruit.imageName }
    var gradientColors: [Color] { fruit.gradientColors }
    var description: String { fruit.description }
    var nutrition: [String] { fruit.nutrition }
}

