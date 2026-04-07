import SwiftUI

enum ExpenseWindow {
    case weekly
    case monthly
}

struct HomeView: View {
    @State private var selectedWindow: ExpenseWindow = .weekly
    @State private var transactions: [Transaction] = Transaction.mock

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    headerSection
                    BalanceCardView()

                    Text("Your expenses")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)

                    ExpenseSegmentControl(selection: $selectedWindow)

                    VStack(spacing: 12) {
                        ForEach(filteredTransactions) { item in
                            ExpenseRowView(transaction: item)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .animation(.easeInOut(duration: 0.25), value: selectedWindow)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 40)
            }
            .background(AppTheme.screenBackground.ignoresSafeArea())
            .navigationTitle("PayU")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var filteredTransactions: [Transaction] {
        switch selectedWindow {
        case .weekly:
            return transactions
        case .monthly:
            return transactions + [
                Transaction(
                    id: UUID(),
                    title: "Shopping",
                    amount: 1700,
                    category: "Lifestyle",
                    note: "One-time purchase",
                    date: Date().addingTimeInterval(-260_000),
                    type: .expense
                )
            ]
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Hey, Alex")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
            Text("Add your yesterday's expense")
                .font(.headline)
                .foregroundStyle(AppTheme.mutedText)
        }
    }
}

#Preview {
    HomeView()
}
