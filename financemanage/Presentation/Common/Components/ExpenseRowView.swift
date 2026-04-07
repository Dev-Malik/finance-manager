import SwiftUI

struct ExpenseRowView: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 34, height: 34)
                Image(systemName: "arrow.2.circlepath")
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title.uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(transaction.note)
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.mutedText)
            }

            Spacer()

            Text(transaction.amount, format: .currency(code: "USD"))
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding(16)
        .background(AppTheme.expenseCardGradient)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
