import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var existingBanks: [Bank]
    
    @State private var creditCard = CreditCard(name: "", isBusiness: false, bank: nil)
    @State private var cardName: String = ""
    @State private var isBusiness: Bool = false
    @State private var selectedBank: Bank?
    @State private var isNewBank: Bool = false

    var body: some View {
        CreditCardFormView(cardName: $cardName, isBusiness: $isBusiness, selectedBank: $selectedBank, isNewBank: isNewBank, existingBanks: existingBanks, creditCard:creditCard) {
            let newCreditCard = CreditCard(name: cardName, isBusiness: isBusiness)
            newCreditCard.bank = selectedBank
            modelContext.insert(newCreditCard)
            dismiss()
        } 
    }
}

#Preview {
    AddCreditCardView(existingBanks: Bank.sampleData)
}
