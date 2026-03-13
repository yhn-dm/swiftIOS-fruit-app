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
            throw FruitDataServiceError.fileNotFound
        }

        let rawString = try String(contentsOf: url, encoding: .utf8)
        return parseFruits(from: rawString)
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

            let gradientLight = Self.colorName(prefix: "Color", suffix: "Light", in: component)
            let gradientDark = Self.colorName(prefix: "Color", suffix: "Dark", in: component)

            let colors: [Color] = [
                Color(gradientLight ?? "ColorBlueberryLight"),
                Color(gradientDark ?? "ColorBlueberryDark")
            ]

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
}

