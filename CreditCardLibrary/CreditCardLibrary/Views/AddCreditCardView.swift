import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var creditCard: CreditCard
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var body: some View {
        
        FormView(
            creditCard: $creditCard,
            isNewBank: false,
            existingBanks: existingBanks,
            paymentProcessors: paymentProcessors
        ) {
            try? modelContext.save()
            dismiss()
        }
    }
}


#Preview {
    AddCreditCardView(creditCard: CreditCard(name: "", creditLimit: "", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: ""), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
}
