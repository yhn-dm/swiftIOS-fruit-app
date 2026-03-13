import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @AppStorage("isOnboarding") private var isOnboarding: Bool = true

    var body: some View {
        TabView {
            ForEach(viewModel.items) { item in
                ZStack {
                    LinearGradient(
                        colors: item.gradientColors,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                    VStack(spacing: 30) {
                        Spacer(minLength: 60)

                        FruitImageLoader.image(for: item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 260)
                            .shadow(radius: 22)

                        VStack(spacing: 12) {
                            Text(item.title)
                                .font(.system(size: 36, weight: .bold, design: .default))
                                .foregroundStyle(.white)

                            Text(item.headline)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }

                        Spacer()

                        Button(action: {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                                isOnboarding = false
                            }
                        }) {
                            HStack(spacing: 12) {
                                Text("Start")
                                    .font(.system(size: 17, weight: .semibold))

                                ZStack {
                                    Circle()
                                        .strokeBorder(Color.white.opacity(0.6), lineWidth: 1.5)
                                        .frame(width: 30, height: 30)

                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 14)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.96))
                            )
                            .foregroundStyle(Color.blue.opacity(0.95))
                            .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 8)
                        }
                        .padding(.bottom, 46)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

#Preview {
    OnboardingView()
}

