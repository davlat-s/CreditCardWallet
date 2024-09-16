import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var existingBanks: [Bank]
    
    @State private var cardName: String = ""
    @State private var isBusiness: Bool = false
    @State private var selectedBank: Bank?
    @State private var isNewBank: Bool = false
    @State private var promotion: Promotion?
    @State private var bonus: Bonus?

    var body: some View {
        FormView(cardName: $cardName, 
                           isBusiness: $isBusiness,
                           promotion: $promotion,
                           selectedBank: $selectedBank,
                           bonus: $bonus, 
                           isNewBank: isNewBank, 
                           existingBanks: existingBanks) {
            let newCreditCard = CreditCard(name: cardName, isBusiness: isBusiness)
            newCreditCard.bank = selectedBank
            newCreditCard.promotion = promotion
            newCreditCard.bonus = bonus
            modelContext.insert(newCreditCard)
            dismiss()
        } 
    }
}

#Preview {
    AddCreditCardView(existingBanks: Bank.sampleData)
}
