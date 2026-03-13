//
// Fichier fruit pour modéliser un fruit de manière agréable à lire.
//

import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let headline: String
    let imageName: String
    let gradientColors: [Color]
    let description: String
    let nutrition: [String]
}

