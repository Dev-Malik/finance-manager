import SwiftUI

struct ExpenseSegmentControl: View {
    @Binding var selection: ExpenseWindow

    var body: some View {
        HStack(spacing: 8) {
            segmentButton(title: "Weekly", value: .weekly)
            segmentButton(title: "Monthly", value: .monthly)
        }
        .padding(6)
        .background(AppTheme.cardBackground)
        .clipShape(Capsule())
    }

    private func segmentButton(title: String, value: ExpenseWindow) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                selection = value
            }
        } label: {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(selection == value ? .black : .white.opacity(0.7))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(selection == value ? Color.white : Color.clear)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
