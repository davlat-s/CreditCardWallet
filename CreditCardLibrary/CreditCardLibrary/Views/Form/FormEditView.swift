import SwiftUI
import SwiftData

//TODO: Decouple applyEdits logic from view

struct FormEditView: View {
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
    
    @Query(sort: [SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    @Query(sort: [SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
    init(creditCard: CreditCard) {
        _creditCard = State(initialValue: creditCard)
        _editedCreditCard = State(initialValue: creditCard.deepCopy())
        _editedBank = State(initialValue: creditCard.bankInstance)
        _editedCardArt = State(initialValue: creditCard.cardArtInstance)
        _editedPromotions = State(initialValue: creditCard.promotionsInstance)
        _editedBonuses = State(initialValue: creditCard.bonusesInstance)
        _editedClosed = State(initialValue: creditCard.closedInstance)
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
                    Button("Save Changes") {
                        Log.action.info("User clicked Save Changes")
                        applyEdits()
                        dismiss()
                    }
                    .disabled(editedCreditCard.name.isEmpty || editedBank == nil || editedCreditCard.lastDigits.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Discard") {
                        Log.action.info("User clicked Discard")
                        resetEdits()
                        dismiss()
                    }
                    .disabled(editedCreditCard.name.isEmpty || editedBank == nil || editedCreditCard.lastDigits.isEmpty)
                }
            }
        }
        .onAppear {
            Log.general.info("FormEditView appeared")
        }
    }
    
    private func applyEdits() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        // Compare name
        if creditCard.name != editedCreditCard.name {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Card name changed from '\(creditCard.name)' to '\(editedCreditCard.name)'"))
            creditCard.name = editedCreditCard.name
        }
        
        // Compare creditLimit
        if creditCard.creditLimit != editedCreditCard.creditLimit {
            let oldLimit = creditCard.creditLimit?.formatted(.currency(code: "USD")) ?? "None"
            let newLimit = editedCreditCard.creditLimit?.formatted(.currency(code: "USD")) ?? "None"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Credit limit changed from \(oldLimit) to \(newLimit)"))
            creditCard.creditLimit = editedCreditCard.creditLimit
        }
        
        // Compare openDate
        if creditCard.openDate != editedCreditCard.openDate {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Open date changed from \(dateFormatter.string(from: creditCard.openDate)) to \(dateFormatter.string(from: editedCreditCard.openDate))"))
            creditCard.openDate = editedCreditCard.openDate
        }
        
        // Compare isBusiness
        if creditCard.isBusiness != editedCreditCard.isBusiness {
            let oldStatus = creditCard.isBusiness ? "Business" : "Personal"
            let newStatus = editedCreditCard.isBusiness ? "Business" : "Personal"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Card type changed from \(oldStatus) to \(newStatus)"))
            creditCard.isBusiness = editedCreditCard.isBusiness
        }
        
        // Compare isChargeCard
        if creditCard.isChargeCard != editedCreditCard.isChargeCard {
            let oldStatus = creditCard.isChargeCard ? "Charge Card" : "Credit Card"
            let newStatus = editedCreditCard.isChargeCard ? "Charge Card" : "Credit Card"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Card type changed from \(oldStatus) to \(newStatus)"))
            creditCard.isChargeCard = editedCreditCard.isChargeCard
        }
        
        // Compare annualFee
        if creditCard.annualFee != editedCreditCard.annualFee {
            let oldFee = creditCard.annualFee?.formatted(.currency(code: "USD")) ?? "None"
            let newFee = editedCreditCard.annualFee?.formatted(.currency(code: "USD")) ?? "None"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Annual fee changed from \(oldFee) to \(newFee)"))
            creditCard.annualFee = editedCreditCard.annualFee
        }
        
        // Compare lastDigits
        if creditCard.lastDigits != editedCreditCard.lastDigits {
            creditCard.history.append(HistoryEntry(date: .now, entry: "Last four digits changed from '\(creditCard.lastDigits)' to '\(editedCreditCard.lastDigits)'"))
            creditCard.lastDigits = editedCreditCard.lastDigits
        }
        
        // Compare bank
        if creditCard.bank?.name != editedBank?.name {
            let oldBank = creditCard.bank?.name ?? "None"
            let newBank = editedBank?.name ?? "None"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Bank changed from '\(oldBank)' to '\(newBank)'"))
            creditCard.bank = editedBank
        }
        
        // Compare promotions
        let addedPromotions = editedPromotions.filter { !creditCard.promotions.contains($0) }
        let removedPromotions = creditCard.promotions.filter { !editedPromotions.contains($0) }
        if !addedPromotions.isEmpty || !removedPromotions.isEmpty {
            let addedList = addedPromotions.map { $0.details }.joined(separator: ", ")
            let removedList = removedPromotions.map { $0.details }.joined(separator: ", ")
            var entry = "Promotions updated."
            if !addedPromotions.isEmpty { entry += " Added: \(addedList)." }
            if !removedPromotions.isEmpty { entry += " Removed: \(removedList)." }
            creditCard.history.append(HistoryEntry(date: .now, entry: entry))
        }
        creditCard.promotions = editedPromotions
        
        // Compare bonuses
        let addedBonuses = editedBonuses.filter { !creditCard.bonuses.contains($0) }
        let removedBonuses = creditCard.bonuses.filter { !editedBonuses.contains($0) }
        if !addedBonuses.isEmpty || !removedBonuses.isEmpty {
            let addedList = addedBonuses.map { $0.details }.joined(separator: ", ")
            let removedList = removedBonuses.map { $0.details }.joined(separator: ", ")
            var entry = "Bonuses updated."
            if !addedBonuses.isEmpty { entry += " Added: \(addedList)." }
            if !removedBonuses.isEmpty { entry += " Removed: \(removedList)." }
            creditCard.history.append(HistoryEntry(date: .now, entry: entry))
        }
        creditCard.bonuses = editedBonuses
        
        // Compare closed
        if creditCard.closed?.reason != editedClosed?.reason {
            let oldClosed = creditCard.closed?.reason ?? "None"
            let newClosed = editedClosed?.reason ?? "None"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Closure reason changed from '\(oldClosed)' to '\(newClosed)'"))
            creditCard.closed = editedClosed
        }
        
        // Compare cardArt
        if creditCard.cardArt?.assetID != editedCardArt?.assetID {
            let oldArt = creditCard.cardArt?.assetID ?? "None"
            let newArt = editedCardArt?.assetID ?? "None"
            creditCard.history.append(HistoryEntry(date: .now, entry: "Card design changed from '\(oldArt)' to '\(newArt)'"))
            creditCard.cardArt = editedCardArt
        }
        
        try? modelContext.save()
    }
    
    private func resetEdits() {
        editedCreditCard = creditCard.deepCopy()
        editedBank = creditCard.bankInstance
        editedCardArt = creditCard.cardArtInstance
        editedPromotions = creditCard.promotionsInstance
        editedBonuses = creditCard.bonusesInstance
        editedClosed = creditCard.closedInstance
        editedPaymentProcessor = creditCard.paymentProcessorInstance
    }
}
