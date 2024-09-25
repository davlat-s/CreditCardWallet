import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var creditCard: CreditCard
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var body: some View {
        FormView(creditCard: $creditCard,
                 isNewBank: false,
                 existingBanks: existingBanks,
                 paymentProcessors: paymentProcessors) {
            try? modelContext.save()
            dismiss()
        }
    }
}



#Preview {
    EditCreditCardView(creditCard: PreviewData.shared.creditCard, existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
}
