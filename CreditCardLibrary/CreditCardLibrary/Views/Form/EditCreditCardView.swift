import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var creditCard: CreditCard
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    
    var body: some View {
        VStack {
            FormView(creditCard: $creditCard,
                     bank: $creditCard.bank,
                     promotions: $creditCard.promotions,
                     bonuses: $creditCard.bonuses,
                     closed: $creditCard.closed,
                     cardArt: $creditCard.cardArt,
                     paymentProcessor: $creditCard.paymentProcessor,
                     existingBanks: existingBanks,
                     paymentProcessors: paymentProcessors)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        try? modelContext.save()
                        dismiss()
                    }
                    .disabled(creditCard.name.isEmpty || creditCard.bank == nil)
                }
            }
        }
    }
}


#Preview {
    EditCreditCardView(creditCard: PreviewData.shared.creditCard, existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
}
