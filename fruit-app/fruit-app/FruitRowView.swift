//
// Une petite tuile qui présente chaque fruit comme sur un joli présentoir.
//

import SwiftUI

struct FruitRowView: View {
    let fruit: Fruit

    var body: some View {
        HStack(spacing: 16) {
            Image(fruit.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .background(
                    LinearGradient(
                        colors: fruit.gradientColors,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 6) {
                Text(fruit.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(fruit.headline)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    if let sample = try? FruitDataService.shared.loadFruits().first {
        FruitRowView(fruit: sample)
            .padding()
            .background(Color(.systemGroupedBackground))
    }
}

