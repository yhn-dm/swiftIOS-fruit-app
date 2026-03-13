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
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                } else {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.green.opacity(0.4))
                        .frame(width: 64, height: 64)
                }

                FruitImageLoader.image(for: fruit.image)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(fruit.title)
                    .font(.headline)

                Text(fruit.headline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
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

