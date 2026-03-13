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
                        Spacer()

                        FruitImageLoader.image(for: item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 260)
                            .padding(32)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.96))
                            )
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 18, x: 0, y: 10)

                        VStack(spacing: 12) {
                            Text(item.title)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)

                            Text(item.headline)
                                .font(.body)
                                .foregroundStyle(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }

                        Spacer()

                        Button(action: {
                            withAnimation(.spring()) {
                                isOnboarding = false
                            }
                        }) {
                            HStack(spacing: 12) {
                                Text("Start")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.95))
                            )
                            .foregroundStyle(Color.black.opacity(0.85))
                            .shadow(color: .black.opacity(0.25), radius: 14, x: 0, y: 6)
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

#Preview {
    OnboardingView()
}

