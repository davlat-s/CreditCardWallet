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
                    .disabled(editedCreditCard.name.isEmpty || editedBank == nil || editedCreditCard.lastDigits.isEmpty)
                }
            }
        }
    }
    
    private func applyEdits() {
        // Compare name
        if creditCard.name != editedCreditCard.name {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Name changed from '\(creditCard.name)' to '\(editedCreditCard.name)'") )
            creditCard.name = editedCreditCard.name
        }
        
        // Compare creditLimit
        if creditCard.creditLimit != editedCreditCard.creditLimit {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Credit limit changed from '\(String(describing: creditCard.creditLimit))' to '\(String(describing: editedCreditCard.creditLimit))'"))
            creditCard.creditLimit = editedCreditCard.creditLimit
        }
        
        // Compare openDate
        if creditCard.openDate != editedCreditCard.openDate {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Open date changed from '\(creditCard.openDate)' to '\(editedCreditCard.openDate)'"))
            creditCard.openDate = editedCreditCard.openDate
        }
        
        // Compare isBusiness
        if creditCard.isBusiness != editedCreditCard.isBusiness {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Business status changed from '\(creditCard.isBusiness)' to '\(editedCreditCard.isBusiness)'"))
            creditCard.isBusiness = editedCreditCard.isBusiness
        }
        
        // Compare isChargeCard
        if creditCard.isChargeCard != editedCreditCard.isChargeCard {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Charge card status changed from '\(creditCard.isChargeCard)' to '\(editedCreditCard.isChargeCard)'"))
            creditCard.isChargeCard = editedCreditCard.isChargeCard
        }
        
        // Compare annualFee
        if creditCard.annualFee != editedCreditCard.annualFee {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Annual fee changed from '\(String(describing: creditCard.annualFee))' to '\(String(describing: editedCreditCard.annualFee))'"))
            creditCard.annualFee = editedCreditCard.annualFee
        }
        
        // Compare lastDigits
        if creditCard.lastDigits != editedCreditCard.lastDigits {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Last digits changed from '\(creditCard.lastDigits)' to '\(editedCreditCard.lastDigits)'"))
            creditCard.lastDigits = editedCreditCard.lastDigits
        }
        
        // Compare bank
        if creditCard.bank?.name != editedBank?.name {
            let oldBank = creditCard.bank?.name ?? "nil"
            let newBank = editedBank?.name ?? "nil"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Bank changed from '\(oldBank)' to '\(newBank)'"))
            creditCard.bank = editedBank
        }
        
        // Compare promotions
        if creditCard.promotions.count != editedPromotions.count {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Promotions updated"))
        }
        creditCard.promotions = editedPromotions
        
        // Compare bonuses
        if creditCard.bonuses.count != editedBonuses.count {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Bonuses updated"))
        }
        creditCard.bonuses = editedBonuses
        
        // Compare closed
        if creditCard.closed?.reason != editedClosed?.reason {
            let oldClosed = creditCard.closed?.reason ?? "nil"
            let newClosed = editedClosed?.reason ?? "nil"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Closed reason changed from '\(oldClosed)' to '\(newClosed)'"))
            creditCard.closed = editedClosed
        }
        
        // Compare paymentProcessor
        if creditCard.paymentProcessor != editedPaymentProcessor {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Payment processor changed from '\(String(describing: creditCard.paymentProcessor))' to '\(String(describing: editedPaymentProcessor))'"))
            creditCard.paymentProcessor = editedPaymentProcessor
        }
        
        // Compare cardArt
        if creditCard.cardArt?.assetID != editedCardArt?.assetID {
            let oldArt = creditCard.cardArt?.assetID ?? "nil"
            let newArt = editedCardArt?.assetID ?? "nil"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Card art changed from '\(oldArt)' to '\(newArt)'"))
            creditCard.cardArt = editedCardArt
        }
        
        try? modelContext.save()
    }
}

//#Preview {
//    EditCreditCardView(creditCard: PreviewData.shared.creditCard, existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
//}
