import SwiftUI

struct FruitDetailView: View {
    let fruit: Fruit

    var body: some View {
        ZStack(alignment: .top) {
            if let firstColor = fruit.gradientColors.first,
               let lastColor = fruit.gradientColors.last {
                LinearGradient(
                    colors: [firstColor, lastColor],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
            }

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    FruitImageLoader.image(for: fruit.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 230)
                        .shadow(radius: 22)
                        .padding(.top, 80)

                    VStack(alignment: .leading, spacing: 18) {
                        Text(fruit.title)
                            .font(.system(size: 32, weight: .bold))

                        Text(fruit.headline)
                            .font(.system(size: 17))
                            .foregroundStyle(.secondary)

                        FruitNutrientsView(nutrition: fruit.nutrition)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Learn more about \(fruit.title)")
                                .font(.system(size: 14, weight: .semibold))
                                .textCase(.uppercase)
                                .foregroundStyle(.secondary)

                            Text(fruit.description)
                                .font(.system(size: 16))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 32)
                    .padding(.bottom, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(Color(.systemBackground))
                            .ignoresSafeArea(edges: .bottom)
                    )
                    .offset(y: 40)
                }
            }
        }
        .navigationTitle(fruit.title)
        .navigationBarTitleDisplayMode(.inline)
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

