import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var creditCard: CreditCard
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]


    @State private var cardName: String
    @State private var isBusiness: Bool
    @State private var lastDigits: String
    @State private var selectedBank: Bank?
    @State private var selectedPP: PaymentProcessor?
    @State private var selectedColor: Color?
    @State private var isNewBank: Bool = false
    @State private var promotion: Promotion?
    @State private var bonus: Bonus?

    init(creditCard: CreditCard, existingBanks: [Bank], paymentProcessors: [PaymentProcessor]) {
        self.creditCard = creditCard
        self.existingBanks = existingBanks
        self.paymentProcessors = paymentProcessors
        _cardName = State(initialValue: creditCard.name)
        _isBusiness = State(initialValue: creditCard.isBusiness)
        _lastDigits = State(initialValue: creditCard.lastDigits)
        _selectedBank = State(initialValue: creditCard.bank)
        _selectedPP = State(initialValue: creditCard.paymentProcessor)
        _promotion = State(initialValue: creditCard.promotion)
        _bonus = State(initialValue: creditCard.bonus)
        _selectedColor = State(initialValue: creditCard.color)
    }

    var body: some View {
        FormView(cardName: $cardName,
                 isBusiness: $isBusiness,
                 lastDigits: $lastDigits,
                 promotion: $promotion,
                 selectedBank: $selectedBank,
                 bonus: $bonus,
                 selectedPP: $selectedPP,
                 selectedColor: $selectedColor, isNewBank: isNewBank,
                 existingBanks: existingBanks,
                 paymentProcessors: paymentProcessors) {
            creditCard.name = cardName
            creditCard.isBusiness = isBusiness
            creditCard.promotion = promotion
            creditCard.bank = selectedBank
            creditCard.bonus = bonus
            creditCard.paymentProcessor = selectedPP
            creditCard.color = selectedColor
            try? modelContext.save()
            dismiss()
        }
    }
}

#Preview {
    EditCreditCardView(creditCard: SampleData.shared.creditCard, existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
}
