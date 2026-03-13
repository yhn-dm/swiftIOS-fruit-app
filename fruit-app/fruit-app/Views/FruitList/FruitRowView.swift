import SwiftUI

struct FruitRowView: View {
    let fruit: Fruit

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                if let firstColor = fruit.gradientColors.first,
                   let lastColor = fruit.gradientColors.last {
                    LinearGradient(
                        colors: [firstColor, lastColor],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                } else {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(Color.green.opacity(0.4))
                        .frame(width: 72, height: 72)
                }

                FruitImageLoader.image(for: fruit.image)
                    .resizable()
                    .scaledToFit()
                    .padding(14)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.92))
                    )
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(fruit.title)
                    .font(.system(size: 18, weight: .semibold))

                Text(fruit.headline)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    FruitRowView(
        fruit: Fruit(
            title: "Blueberry",
            headline: "Blueberries are sweet, nutritious and wildly popular fruit all over the world.",
            image: "blueberry",
            gradientColors: [Color.blue.opacity(0.6), Color.blue],
            description: "Preview description",
            nutrition: []
        )
    )
    .padding()
}

