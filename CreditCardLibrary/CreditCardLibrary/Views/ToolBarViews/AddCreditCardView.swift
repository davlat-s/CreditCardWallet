import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var creditCard: CreditCard
    @State var bank: Bank? = nil
    @State var promo: Promotion? = nil
    @State var bonus: Bonus? = nil
    @State var closed: Closed? = nil
    @State var cardArt: CardArt? = CardArt.returnNewCardArt()
    @State var paymentProcessor: PaymentProcessor? = PaymentProcessor.returnNewPaymentProcessor()
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    
    var body: some View {
        VStack {
            FormView(creditCard: $creditCard,
                     bank: $bank,
                     promo: $promo,
                     bonus: $bonus,
                     closed: $closed,
                     cardArt: $cardArt,
                     paymentProcessor: $paymentProcessor,
                     existingBanks: existingBanks,
                     paymentProcessors: paymentProcessors)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        creditCard.bank = bank
                        creditCard.promotion = promo
                        creditCard.bonus = bonus
                        creditCard.closed = closed
                        creditCard.cardArt = cardArt
                        creditCard.paymentProcessor = paymentProcessor
                        
                        modelContext.insert(creditCard)
                        
                        try? modelContext.save()
                        dismiss()
                    }
                    .disabled(creditCard.name.isEmpty || bank == nil || paymentProcessor == nil || creditCard.lastDigits.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        modelContext.delete(creditCard)
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    AddCreditCardView(creditCard: CreditCard(name: "", creditLimit: "", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: ""), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
}
