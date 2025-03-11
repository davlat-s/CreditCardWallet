import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var creditCard: CreditCard
    @State private var editedCreditCard: CreditCard
    @State private var editedBank: Bank?
    @State private var editedCardArt: CardArt?
    @State private var editedPromotions: [Promotion]
    @State private var editedBonuses: [Bonus]
    @State private var editedClosed: Closed?
    @State private var editedPaymentProcessor: PaymentProcessor?
    
    
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    
    init(creditCard: CreditCard, existingBanks: [Bank], paymentProcessors: [PaymentProcessor]) {
        _creditCard = State(initialValue: creditCard)
        _editedCreditCard = State(initialValue: creditCard.deepCopy())
        _editedBank = State(initialValue: creditCard.bankInstance)
        _editedCardArt = State(initialValue: creditCard.cardArtInstance)
        _editedPromotions = State(initialValue: creditCard.promotionsInstance)
        _editedBonuses = State(initialValue: creditCard.bonusesInstance)
        _editedClosed = State(initialValue: creditCard.closedInstance)
        self.existingBanks = existingBanks
        self.paymentProcessors = paymentProcessors
    }
    
    
    var body: some View {
        VStack {
            FormView(creditCard: $editedCreditCard,
                     bank: $editedBank,
                     promotions: $editedPromotions,
                     bonuses: $editedBonuses,
                     closed: $editedClosed,
                     cardArt: $editedCardArt,
                     paymentProcessor: $editedPaymentProcessor,
                     existingBanks: existingBanks,
                     paymentProcessors: paymentProcessors)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        applyEdits()
                        dismiss()
                    }
                    .disabled(creditCard.name.isEmpty || creditCard.bank == nil || creditCard.lastDigits.isEmpty)
                }
            }
        }
    }
    
    private func applyEdits() {
        creditCard.name = editedCreditCard.name
        creditCard.creditLimit = editedCreditCard.creditLimit
        creditCard.openDate = editedCreditCard.openDate
        creditCard.isBusiness = editedCreditCard.isBusiness
        creditCard.isChargeCard = editedCreditCard.isChargeCard
        creditCard.annualFee = editedCreditCard.annualFee
        creditCard.lastDigits = editedCreditCard.lastDigits
            
            creditCard.bank = editedBank
            creditCard.promotions = editedPromotions
            creditCard.bonuses = editedBonuses
            creditCard.closed = editedClosed
            creditCard.paymentProcessor = editedPaymentProcessor
            creditCard.cardArt = editedCardArt
            
            try? modelContext.save()
        }

}


//#Preview {
//    EditCreditCardView(creditCard: PreviewData.shared.creditCard, existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
//}
