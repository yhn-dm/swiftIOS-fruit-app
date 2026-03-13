import SwiftUI

struct FruitDetailView: View {
    @StateObject private var viewModel: FruitDetailViewModel

    init(fruit: Fruit) {
        _viewModel = StateObject(wrappedValue: FruitDetailViewModel(fruit: fruit))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                mainInfo
                nutritionSection
                learnMoreSection
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        ZStack {
            LinearGradient(
                colors: viewModel.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 16) {
                Spacer(minLength: 20)

                Image(viewModel.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 260)
                    .shadow(radius: 16)

                Text(viewModel.title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                Text(viewModel.headline)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Spacer(minLength: 24)
            }
            .padding(.top, 40)
        }
        .frame(height: 360)
    }

    private var mainInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.title)
                .font(.title2.bold())

            Text(viewModel.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }

    private var nutritionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Nutritional value per 100g")
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }

            VStack(spacing: 8) {
                ForEach(nutritionRows.indices, id: \.self) { index in
                    let row = nutritionRows[index]
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "info.circle")
                            .foregroundColor(viewModel.gradientColors.first ?? .green)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(row.label)
                                .font(.subheadline).bold()
                            Text(row.value)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }

                        Spacer()
                    }
                    .padding(.vertical, 4)

                    if index != nutritionRows.indices.last {
                        Divider()
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 24)
    }

    private var learnMoreSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Learn more about \(viewModel.title)")
                .font(.headline)

            Text(viewModel.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }

    private var nutritionRows: [(label: String, value: String)] {
        let values = viewModel.nutrition
        let labels = ["Energy", "Sugar", "Fat", "Protein", "Vitamins", "Minerals"]

        return zip(labels.indices, labels).map { index, label in
            let value = values.indices.contains(index) ? values[index] : "-"
            return (label: label, value: value)
        }
    }
}

#Preview {
    if let sample = try? FruitDataService.shared.loadFruits().first {
        NavigationStack {
            FruitDetailView(fruit: sample)
        }
    }
}

