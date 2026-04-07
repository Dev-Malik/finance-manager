import SwiftUI

struct BalanceCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("ADRBank")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.85))
                Spacer()
                Image(systemName: "arrow.triangle.2.circlepath")
                    .foregroundStyle(.white.opacity(0.9))
            }

            Text("8763 1111 2222 0329")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white.opacity(0.95))

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Card Holder Name")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.75))
                    Text("ALEX")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.95))
                }

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Expired Date")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.75))
                    Text("10/28")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.95))
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 180)
        .background(AppTheme.accentGradient)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

#Preview {
    ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        BalanceCardView()
            .padding()
    }
}
