import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
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
                    modelContext.delete(creditCard)
                    dismiss()
                }
            )
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        try? modelContext.save()
                        dismiss()
                        filterCallback()
                    }
                    .disabled(creditCard.name.isEmpty || creditCard.bank == nil || creditCard.paymentProcessor == nil || creditCard.lastDigits.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        modelContext.delete(creditCard)
                        dismiss()
                        filterCallback()
                    }
                }
            }
        }
    }
}


#Preview {
    AddCreditCardView(creditCard: CreditCard(name: "", creditLimit: "", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: ""), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData, filterCallback: {print("test")})
}
