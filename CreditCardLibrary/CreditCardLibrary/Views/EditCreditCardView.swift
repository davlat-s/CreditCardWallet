import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var creditCard: CreditCard
    var existingBanks: [Bank]

    @State private var cardName: String
    @State private var isBusiness: Bool
    @State private var selectedBank: Bank?
    @State private var isNewBank: Bool = false

    init(creditCard: CreditCard, existingBanks: [Bank]) {
        self.creditCard = creditCard
        self.existingBanks = existingBanks
        _cardName = State(initialValue: creditCard.name)
        _isBusiness = State(initialValue: creditCard.isBusiness)
        _selectedBank = State(initialValue: creditCard.bank)
    }

    var body: some View {
        CreditCardFormView(cardName: $cardName, isBusiness: $isBusiness, selectedBank: $selectedBank, isNewBank: isNewBank, existingBanks: existingBanks, creditCard: creditCard) {
            creditCard.name = cardName
            creditCard.isBusiness = isBusiness
            creditCard.bank = selectedBank
            try? modelContext.save()
            dismiss()
        }
    }
}

#Preview {
    EditCreditCardView(creditCard: SampleData.shared.creditCard, existingBanks: Bank.sampleData)
}
