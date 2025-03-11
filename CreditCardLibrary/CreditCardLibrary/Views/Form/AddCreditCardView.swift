import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var creditCard: CreditCard
    @State var bank: Bank? = nil
    @State var promotions: [Promotion] = []
    @State var bonuses: [Bonus] = []
    @State var closed: Closed? = nil
    @State var cardArt: CardArt? = nil
    @State var paymentProcessor: PaymentProcessor? = PaymentProcessor.returnNewPaymentProcessor()
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    
    var body: some View {
        VStack {
            FormView(creditCard: $creditCard,
                     bank: $bank,
                     promotions: $promotions,
                     bonuses: $bonuses,
                     closed: $closed,
                     cardArt: $cardArt,
                     paymentProcessor: $paymentProcessor,
                     existingBanks: existingBanks,
                     paymentProcessors: paymentProcessors)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add Card") {
                        creditCard.bank = bank
                        creditCard.promotions = promotions
                        creditCard.bonuses = bonuses
                        creditCard.closed = closed
                        creditCard.cardArt = cardArt
                        creditCard.paymentProcessor = paymentProcessor
                        
                        modelContext.insert(creditCard)
                        
                        try? modelContext.save()
                        dismiss()
                    }
                    .disabled(creditCard.name.isEmpty || bank == nil)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Discard") {
                        modelContext.delete(creditCard)
                        dismiss()
                    }
                }
            }
        }
    }
}


//#Preview {
//    AddCreditCardView(creditCard: CreditCard(name: "", creditLimit: "", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: ""), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
//}
