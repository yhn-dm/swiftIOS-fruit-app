import SwiftUI

struct FruitDetailView: View {
    let fruit: Fruit

    private var headerGradient: LinearGradient {
        if let first = fruit.gradientColors.first,
           let last = fruit.gradientColors.last {
            return LinearGradient(
                colors: [first, last],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [Color.orange.opacity(0.6), Color.orange.opacity(0.2)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ZStack {
                    headerGradient
                        .frame(height: 340)
                        .ignoresSafeArea(edges: .top)

                    FruitImageLoader.image(for: fruit.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 230)
                        .padding(30)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.96))
                        )
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 10)
                }

                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(fruit.title)
                            .font(.largeTitle.bold())

                        Text(fruit.headline)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }

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
                .padding(.top, 24)
                .padding(.bottom, 32)
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: -4)
                )
            }
        }
        .navigationTitle(fruit.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(headerGradient.ignoresSafeArea())
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

