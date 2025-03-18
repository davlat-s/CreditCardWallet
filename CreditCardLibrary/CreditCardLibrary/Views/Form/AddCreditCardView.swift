import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    @Query(sort: [SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
    @State var creditCard: CreditCard = CreditCard.returnNewCreditCard()
    @State var bank: Bank? = nil
    @State var promotions: [Promotion] = []
    @State var bonuses: [Bonus] = []
    @State var closed: Closed? = nil
    @State var cardArt: CardArt? = nil
    @State var paymentProcessor: PaymentProcessor? = PaymentProcessor.returnNewPaymentProcessor()
    
    
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
                        creditCard.history.append(HistoryEntry(date: .now, entry: "\(creditCard.name) was added"))
                        
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
            .onAppear {
                creditCard = CreditCard.returnNewCreditCard()
            }
        }
    }
}


//#Preview {
//    AddCreditCardView(creditCard: CreditCard(name: "", creditLimit: "", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: ""), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData)
//}
