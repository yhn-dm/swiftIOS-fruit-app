import Foundation
import SwiftUI

enum FruitDataServiceError: Error {
    case fileNotFound
    case unreadableData
}

final class FruitDataService {
    static let shared = FruitDataService()

    private init() {}

    func loadFruits() throws -> [Fruit] {
        guard let url = Bundle.main.url(forResource: "FruitsData", withExtension: "txt") else {
            return Self.fallbackFruits
        }

        do {
            let rawString = try String(contentsOf: url, encoding: .utf8)
            let parsed = parseFruits(from: rawString)
            return parsed.isEmpty ? Self.fallbackFruits : parsed
        } catch {
            return Self.fallbackFruits
        }
    }

    private func parseFruits(from raw: String) -> [Fruit] {
        var fruits: [Fruit] = []

        let components = raw.components(separatedBy: "Fruit(").dropFirst()

        for component in components {
            let title = Self.value(for: "title", in: component) ?? "Unknown"
            let headline = Self.value(for: "headline", in: component) ?? ""
            let image = Self.value(for: "image", in: component) ?? ""
            let description = Self.multilineValue(for: "description", in: component) ?? ""
            let nutritionArray = Self.arrayValue(for: "nutrition", in: component)

            let colors = Self.defaultGradient(for: title)

            let fruit = Fruit(
                title: title,
                headline: headline,
                imageName: image,
                gradientColors: colors,
                description: description,
                nutrition: nutritionArray
            )

            fruits.append(fruit)
        }

        return fruits
    }

    private static func value(for key: String, in text: String) -> String? {
        guard let range = text.range(of: "\(key):") else { return nil }
        let substring = text[range.upperBound...]
        guard let endOfLine = substring.firstIndex(of: ",") else { return nil }
        let valuePart = substring[..<endOfLine]
        let cleaned = valuePart
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .trimmingCharacters(in: .whitespaces)
        return cleaned
    }

    private static func multilineValue(for key: String, in text: String) -> String? {
        guard let range = text.range(of: "\(key):") else { return nil }
        let substring = text[range.upperBound...]
        guard let start = substring.range(of: "\"\"\"")?.upperBound else { return nil }
        guard let end = substring.range(of: "\"\"\"", range: start..<substring.endIndex)?.lowerBound else { return nil }
        let inner = substring[start..<end]
        return String(inner).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func arrayValue(for key: String, in text: String) -> [String] {
        guard let range = text.range(of: "\(key):") else { return [] }
        let substring = text[range.upperBound...]
        guard let start = substring.firstIndex(of: "[") else { return [] }
        guard let end = substring.firstIndex(of: "]") else { return [] }
        let inner = substring[substring.index(after: start)..<end]
        let parts = inner.split(separator: ",")
        return parts.map {
            $0.replacingOccurrences(of: "\"", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    private static func colorName(prefix: String, suffix: String, in text: String) -> String? {
        let pattern = "\(prefix)[A-Za-z]+\(suffix)"
        if let range = text.range(of: pattern, options: .regularExpression) {
            return String(text[range])
        }
        return nil
    }

    private static func defaultGradient(for title: String) -> [Color] {
        switch title.lowercased() {
        case "strawberry":
            return [Color.red, Color.pink]
        case "lemon", "lime":
            return [Color.yellow, Color.orange]
        case "plum", "grape", "grapefruit":
            return [Color.purple, Color.pink]
        case "pomegranate", "cherry":
            return [Color.red, Color.orange]
        case "pear", "gooseberry":
            return [Color.green, Color.yellow]
        case "mango":
            return [Color.orange, Color.red]
        case "watermelon":
            return [Color.red, Color.green]
        case "apple":
            return [Color.green, Color.red]
        default:
            return [Color.blue, Color.purple]
        }
    }

    private static let fallbackFruits: [Fruit] = [
        Fruit(
            title: "Blueberry",
            headline: "Blueberries are sweet, nutritious and wildly popular fruit all over the world.",
            imageName: "blueberry",
            gradientColors: defaultGradient(for: "Blueberry"),
            description: "Blueberries are perennial flowering plants with blue or purple berries and are widely appreciated for their taste and health benefits.",
            nutrition: ["240 kJ (57 kcal)", "9.96 g", "0.33 g", "0.74 g", "Vitamins A, C, K", "Manganese, Iron, Calcium"]
        ),
        Fruit(
            title: "Strawberry",
            headline: "Widely appreciated for its aroma, red color, juicy texture, and sweetness.",
            imageName: "strawberry",
            gradientColors: defaultGradient(for: "Strawberry"),
            description: "Strawberries are cultivated worldwide and enjoyed fresh or in many desserts and drinks.",
            nutrition: ["136 kJ (33 kcal)", "4.89 g", "0.3 g", "0.67 g", "Vitamin C, B vitamins", "Calcium, Iron, Magnesium"]
        ),
        Fruit(
            title: "Grapefruit",
            headline: "Sweet, bell-shaped fruits that have been enjoyed since ancient times.",
            imageName: "grapefruit",
            gradientColors: defaultGradient(for: "Grapefruit"),
            description: "Grapefruit is a citrus hybrid known for its sour to semi-sweet taste and refreshing juice.",
            nutrition: ["138 kJ (33 kcal)", "7.31 g", "0.10 g", "0.8 g", "Vitamin C, E", "Calcium, Potassium"]
        )
    ]
}

