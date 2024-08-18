import SwiftUI
import SwiftData

struct addCreditCardSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @Query var creditCards: [CreditCard]
    
    @State var id: String = ""
    @State var cardName: String = ""
    @State var bankName: String = ""
    @State var openDate: Date = .now
    @State var annualFee: Int = 0
    @State var dueDay: Int = 0
    @State var creditLimit: Double = 0
    @State var isChargeCard: Bool = false
    @State var isBusiness: Bool = false
    @State var isClosed: Bool = false
    @State var wasDowngraded: Bool = false
    @State var hasAPRPromotion: Bool = false
    @State var hasBonusPromotion: Bool = false
    @State var imageName: String = "1"
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Card Name", text: $cardName)
                DatePicker("Open Date", selection: $openDate, displayedComponents: .date)
                TextField("Credit Limit", value: $creditLimit, format: .number)
                TextField("Last Digits", text: $id)
                TextField("Bank Name", text: $bankName)
                TextField("Annual Fee", value: $annualFee, format: .number)
                Toggle("Charge Card", isOn: $isChargeCard)
            }
            .navigationTitle("New Card")
            .toolbar {
                ToolbarItemGroup {
                    Button("Cancel"){dismiss()}
                    Button("Save") {
                        let card = CreditCard(id: id, cardName: cardName, bankName: bankName, openDate: openDate, annualFee: annualFee, dueDay: dueDay, creditLimit: creditLimit, isChargeCard: isChargeCard, isBusiness: isBusiness, isClosed: isClosed, wasDowngraded: wasDowngraded, hasAPRPromotion: hasAPRPromotion, hasBonusPromotion: hasBonusPromotion, imageName: imageName)
                        context.insert(card)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    addCreditCardSheet()
}
