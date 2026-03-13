import SwiftUI

struct FruitDetailView: View {
    let fruit: Fruit

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                ZStack {
                    if let firstColor = fruit.gradientColors.first,
                       let lastColor = fruit.gradientColors.last {
                        LinearGradient(
                            colors: [firstColor, lastColor],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    } else {
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(Color.orange.opacity(0.3))
                            .frame(height: 320)
                    }

                    FruitImageLoader.image(for: fruit.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .shadow(radius: 20)
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: 16) {
                    Text(fruit.title)
                        .font(.largeTitle.bold())

                    Text(fruit.headline)
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    FruitNutrientsView(nutrition: fruit.nutrition)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Learn more about \(fruit.title)")
                            .font(.headline)
                            .textCase(.uppercase)

                        Text(fruit.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle(fruit.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

#Preview {
    FruitDetailView(
        fruit: Fruit(
            title: "Grapefruit",
            headline: "Sweet, bell-shaped fruits that have been enjoyed since ancient times.",
            image: "grapefruit",
            gradientColors: [Color.orange.opacity(0.7), Color.orange],
            description: "Preview description about grapefruit.",
            nutrition: [
                "138 kJ (33 kcal)",
                "7.31 g",
                "0.10 g",
                "0.8 g",
                "B1, B2, B3, B5, B6, B9, C, E",
                "Calcium, Iron, Phosphorus, Potassium, Zinc"
            ]
        )
    )
}

