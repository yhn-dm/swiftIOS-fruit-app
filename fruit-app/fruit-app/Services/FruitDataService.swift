import SwiftUI

enum FruitDataService {
    static func loadFruits() -> [Fruit] {
        guard let url = Bundle.main.url(
            forResource: "FruitsData",
            withExtension: "txt",
            subdirectory: "Resources/Resources/Data"
        ) else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            guard let content = String(data: data, encoding: .utf8) else {
                return []
            }

            return parseFruits(from: content)
        } catch {
            return []
        }
    }

    private static func parseFruits(from content: String) -> [Fruit] {
        var fruits: [Fruit] = []

        let rawBlocks = content.components(separatedBy: "Fruit(")
        for rawBlock in rawBlocks {
            guard rawBlock.contains("title:") else { continue }

            func extractValue(for key: String) -> String? {
                guard let range = rawBlock.range(of: "\(key):") else { return nil }
                let substringFromKey = rawBlock[range.upperBound...]

                guard let endOfLine = substringFromKey.firstIndex(of: "\n") else { return nil }
                let line = substringFromKey[..<endOfLine]
                let cleaned = line
                    .replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: ",", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                return cleaned
            }

            let title = extractValue(for: "title") ?? "Unknown"
            let headline = extractValue(for: "headline") ?? ""
            let image = extractValue(for: "image") ?? ""

            var gradientColors: [Color] = []
            if let gradientRange = rawBlock.range(of: "gradientColors:") {
                let substringFromGradient = rawBlock[gradientRange.upperBound...]
                if let closingBracket = substringFromGradient.firstIndex(of: "]") {
                    let gradientBlock = substringFromGradient[..<closingBracket]
                    let colorNames = gradientBlock.components(separatedBy: "Color(")
                    for colorNamePart in colorNames {
                        guard let endIndex = colorNamePart.firstIndex(of: ")") else { continue }
                        let rawName = colorNamePart[..<endIndex]
                        let cleanedName = rawName
                            .replacingOccurrences(of: "\"", with: "")
                            .replacingOccurrences(of: ",", with: "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        if !cleanedName.isEmpty {
                            gradientColors.append(Color(cleanedName))
                        }
                    }
                }
            }

            var descriptionText = ""
            if let descriptionRange = rawBlock.range(of: "description: \"\"\"") {
                let substringFromDescription = rawBlock[descriptionRange.upperBound...]
                if let endDescriptionRange = substringFromDescription.range(of: "\"\"\"") {
                    let descriptionBlock = substringFromDescription[..<endDescriptionRange.lowerBound]
                    descriptionText = String(descriptionBlock).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }

            var nutritionValues: [String] = []
            if let nutritionRange = rawBlock.range(of: "nutrition: [") {
                let substringFromNutrition = rawBlock[nutritionRange.upperBound...]
                if let closingBracket = substringFromNutrition.firstIndex(of: "]") {
                    let nutritionBlock = substringFromNutrition[..<closingBracket]
                    let items = nutritionBlock.components(separatedBy: "\"")
                    for (index, item) in items.enumerated() where index % 2 == 1 {
                        let cleaned = item.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !cleaned.isEmpty {
                            nutritionValues.append(cleaned)
                        }
                    }
                }
            }

            let fruit = Fruit(
                title: title,
                headline: headline,
                image: image,
                gradientColors: gradientColors,
                description: descriptionText,
                nutrition: nutritionValues
            )

            fruits.append(fruit)
        }

        return fruits
    }
}

