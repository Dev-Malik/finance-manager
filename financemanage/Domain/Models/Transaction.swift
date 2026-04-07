import Foundation

enum TransactionType: String, CaseIterable, Codable {
    case income
    case expense
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var category: String
    var note: String
    var date: Date
    var type: TransactionType
}

extension Transaction {
    static let mock: [Transaction] = [
        Transaction(
            id: UUID(),
            title: "Food",
            amount: 1000,
            category: "Dining",
            note: "Lesser than last week",
            date: Date(),
            type: .expense
        ),
        Transaction(
            id: UUID(),
            title: "Travel",
            amount: 4000,
            category: "Transport",
            note: "More than last week",
            date: Date().addingTimeInterval(-86_400),
            type: .expense
        )
    ]
}
