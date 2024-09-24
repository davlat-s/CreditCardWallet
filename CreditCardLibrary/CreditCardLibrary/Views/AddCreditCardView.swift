import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    @State private var cardName: String = ""
    @State private var creditLimit: String = ""
    @State private var openDate: Date = .now
    @State private var isBusiness: Bool = false
    @State private var isChargeCard: Bool = false
    @State private var selectedBank: Bank?
    @State private var selectedPP: PaymentProcessor?
    @State private var selectedColor: Color?
    @State private var isNewBank: Bool = false
    @State private var promotion: Promotion?
    @State private var bonus: Bonus?
    @State private var lastDigits: String = ""

    var body: some View {
        FormView(cardName: $cardName,
                 creditLimit: $creditLimit,
                 openDate: $openDate,
                 isBusiness: $isBusiness,
                 isChargeCard: $isChargeCard,
                 lastDigits: $lastDigits,
                 promotion: $promotion,
                 selectedBank: $selectedBank,
                 bonus: $bonus,
                 selectedPP: $selectedPP,
                 selectedColor: $selectedColor, isNewBank: isNewBank,
                 existingBanks: existingBanks,
                 paymentProcessors: paymentProcessors) {
            let newCreditCard = CreditCard(name: cardName, creditLimit: creditLimit, openDate: openDate, isBusiness: isBusiness, isChargeCard: isChargeCard, lastDigits: lastDigits)
            newCreditCard.bank = selectedBank
            newCreditCard.promotion = promotion
            newCreditCard.bonus = bonus
            newCreditCard.paymentProcessor = selectedPP
            newCreditCard.color = selectedColor
            modelContext.insert(newCreditCard)
            dismiss()
        }
    }
}

#Preview {
    AddCreditCardView(existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
}
