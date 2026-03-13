import SwiftUI

enum FruitImageLoader {
    static func image(for name: String) -> Image {
        if let uiImage = loadUIImage(named: name) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "photo")
    }

    private static func loadUIImage(named name: String) -> UIImage? {
        let candidates: [(resource: String, subdirectory: String?)] = [
            (name, nil),
            (name, "Fruits"),
            (name, "Resources/Fruits"),
            (name, "Resources/Resources/Fruits")
        ]

        for candidate in candidates {
            if let url = Bundle.main.url(
                forResource: candidate.resource,
                withExtension: "png",
                subdirectory: candidate.subdirectory
            ) {
                if let image = UIImage(contentsOfFile: url.path) {
                    return image
                }
            }
        }

        return nil
    }
}

