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
            FormView(
                creditCard: $creditCard,
                isNewBank: false,
                existingBanks: existingBanks,
                paymentProcessors: paymentProcessors,
                onSave: {
                    try? modelContext.save()
                    dismiss()
                },
                onCancel: {
                    dismiss()
                }
            )
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
