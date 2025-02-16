import SwiftUI
import SwiftData

struct EditCreditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var creditCard: CreditCard
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var filterCallback: () -> Void
    
    var body: some View {
        VStack {
            FormView(creditCard: $creditCard,
                     bank: $creditCard.bank,
                     promo: $creditCard.promotion,
                     bonus: $creditCard.bonus,
                     closed: $creditCard.closed,
                     cardArt: $creditCard.cardArt,
                     paymentProcessor: $creditCard.paymentProcessor,
                     existingBanks: existingBanks,
                     paymentProcessors: paymentProcessors)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        try? modelContext.save()
                        dismiss()
                        filterCallback()
                    }
                    .disabled(creditCard.name.isEmpty || creditCard.bank == nil || creditCard.paymentProcessor == nil || creditCard.lastDigits.isEmpty)
                }
            }
        }
    }
}


#Preview {
    EditCreditCardView(creditCard: PreviewData.shared.creditCard, existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData, filterCallback: {print("test")})
}
