import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var creditCard: CreditCard
    var existingBanks: [Bank]

    @State private var cardName: String
    @State private var isBusiness: Bool
    @State private var lastDigits: String
    @State private var selectedBank: Bank?
    @State private var isNewBank: Bool = false
    @State private var promotion: Promotion?
    @State private var bonus: Bonus?

    init(creditCard: CreditCard, existingBanks: [Bank]) {
        self.creditCard = creditCard
        self.existingBanks = existingBanks
        _cardName = State(initialValue: creditCard.name)
        _isBusiness = State(initialValue: creditCard.isBusiness)
        _lastDigits = State(initialValue: creditCard.lastDigits)
        _selectedBank = State(initialValue: creditCard.bank)
        _promotion = State(initialValue: creditCard.promotion)
        _bonus = State(initialValue: creditCard.bonus)
    }

    var body: some View {
        FormView(cardName: $cardName, 
                           isBusiness: $isBusiness,
                 lastDigits: $lastDigits,
                           promotion: $promotion,
                           selectedBank: $selectedBank, 
                           bonus: $bonus,
                           isNewBank: isNewBank,
                           existingBanks: existingBanks) {
            creditCard.name = cardName
            creditCard.isBusiness = isBusiness
            creditCard.promotion = promotion
            creditCard.bank = selectedBank
            creditCard.bonus = bonus
            try? modelContext.save()
            dismiss()
        }
    }
}

#Preview {
    EditCreditCardView(creditCard: SampleData.shared.creditCard, existingBanks: Bank.sampleData)
}
