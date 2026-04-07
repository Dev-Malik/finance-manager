import SwiftUI

struct TransactionsView: View {
    @State private var amount = ""
    @State private var selectedType: TransactionType = .expense
    @State private var selectedDate = Date()
    @State private var category = "Food"
    @State private var note = ""
    @FocusState private var isNoteFocused: Bool

    private let categories = ["Food", "Travel", "Shopping", "Salary", "Bills", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Type") {
                    Picker("Transaction Type", selection: $selectedType) {
                        ForEach(TransactionType.allCases, id: \.rawValue) { kind in
                            Text(kind.rawValue.capitalized).tag(kind)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Details") {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)

                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self, content: Text.init)
                    }

                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)

                    TextField("Note", text: $note, axis: .vertical)
                        .lineLimit(2...4)
                        .focused($isNoteFocused)
                }

                Section {
                    Button("Add Transaction") {
                        isNoteFocused = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(amount.isEmpty)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isNoteFocused = false
                    }
                }
            }
            .navigationTitle("Add Transaction")
        }
    }
}

#Preview {
    TransactionsView()
}
