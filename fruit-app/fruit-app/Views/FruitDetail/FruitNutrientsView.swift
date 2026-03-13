import SwiftUI

struct FruitNutrientsView: View {
    let nutrition: [String]

    private let labels = ["Energy", "Sugar", "Fat", "Protein", "Vitamins", "Minerals"]

    var body: some View {
        DisclosureGroup("Nutritional value per 100g") {
            VStack(spacing: 8) {
                ForEach(labels.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.orange)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(labels[index])
                                .font(.subheadline.weight(.semibold))

                            if nutrition.indices.contains(index) {
                                Text(nutrition[index])
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        Spacer()
                    }
                    .padding(.vertical, 6)

                    if index < labels.indices.last {
                        Divider()
                    }
                }
            }
            .padding(.top, 4)
        }
        .font(.body)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground).opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.orange.opacity(0.25))
        )
    }
}

#Preview {
    FruitNutrientsView(
        nutrition: [
            "138 kJ (33 kcal)",
            "7.31 g",
            "0.10 g",
            "0.8 g",
            "B1, B2, B3, B5, B6, B9, C, E",
            "Calcium, Iron, Phosphorus, Potassium, Zinc"
        ]
    )
    .padding()
}

