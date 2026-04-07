import SwiftUI

enum AppTheme {
    static let screenBackground = Color(red: 0.03, green: 0.04, blue: 0.07)
    static let cardBackground = Color.white.opacity(0.08)
    static let mutedText = Color.white.opacity(0.65)
    static let accentGradient = LinearGradient(
        colors: [
            Color(red: 0.84, green: 0.79, blue: 0.72),
            Color(red: 0.23, green: 0.87, blue: 0.77)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let expenseCardGradient = LinearGradient(
        colors: [Color.white.opacity(0.09), Color.white.opacity(0.03)],
        startPoint: .leading,
        endPoint: .trailing
    )
}
