import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Binding var creditCard: CreditCard
    @State var isNewBank: Bool = false
    @State var isNewPromo: Bool = false
    @State var isNewBonus: Bool = false
    @State var textFieldWidth: CGFloat = 236
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var onSave: () -> Void
    
    var body: some View {
        ScrollView {
            Form {
                CardView(creditCard: creditCard)
                    .frame(width: 48.6, height: 30.6, alignment: .init(horizontal: .leading, vertical: .center))
                    .scaleEffect(0.3)
                    .padding(.top, 80)
                    .padding(.bottom,50)
                ColorPicker("Card Color", selection: Binding(
                    get: { creditCard.color ?? .gray },
                    set: { newColor in
                        creditCard.color = newColor
                    }))
                    .pickerStyle(.inline)
                
                DatePicker("Open Date", selection: $creditCard.openDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                
                TextField("Card Name", text: $creditCard.name)
                    .textContentType(.creditCardName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Last Digits", text: $creditCard.lastDigits)
                    .textContentType(.creditCardNumber)
                    .textFieldStyle(.roundedBorder)
                
                Toggle("Charge Card", isOn: $creditCard.isChargeCard)
                    .onChange(of: creditCard.isChargeCard) {
                        if creditCard.isChargeCard {
                            creditCard.creditLimit = "0"
                        }
                    }
                
                TextField("Credit Limit", text: $creditCard.creditLimit)
                    .disabled(creditCard.isChargeCard)
                    .opacity(creditCard.isChargeCard ? 0.5 : 1.0)
                
                Toggle("Business", isOn: $creditCard.isBusiness)
                
                Picker("Payment Processor", selection: $creditCard.paymentProcessor) {
                    ForEach(paymentProcessors) { pp in
                        Text(pp.name).tag(Optional(pp))
                    }
                }
                .pickerStyle(.menu)
                .padding(.leading, 20)
                Divider()
                
                if !existingBanks.isEmpty {
                    Picker("Bank", selection: $creditCard.bank) {
                        ForEach(existingBanks) { bank in
                            Text(bank.name).tag(Optional(bank))
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Toggle("New Bank", isOn: $isNewBank)
                
                if isNewBank {
                    AddBankView(textFieldWidth: $textFieldWidth) { newBank in
                        modelContext.insert(newBank)
                        creditCard.bank = newBank
                    }
                }
                Divider()
                Text(creditCard.promotion?.name ?? "No Promotions")
                
                Toggle("New Promo", isOn: $isNewPromo)
                
                if isNewPromo {
                    AddPromotionView(textFieldWidth: $textFieldWidth) { newPromo in
                        modelContext.insert(newPromo)
                        creditCard.promotion = newPromo
                    }
                }
                Divider()
                Text(creditCard.bonus?.name ?? "No Bonuses")
                
                Toggle("New Bonus", isOn: $isNewBonus)
                
                if isNewBonus {
                    AddBonusView(textFieldWidth: $textFieldWidth) { newBonus in
                        modelContext.insert(newBonus)
                        creditCard.bonus = newBonus
                    }
                }
            }
        }
        .onAppear {
            if existingBanks.isEmpty {
                isNewBank = true
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    onSave()
                }
                .disabled(creditCard.name.isEmpty || creditCard.bank == nil || creditCard.paymentProcessor == nil || creditCard.lastDigits.isEmpty)
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


#Preview {
    FormView(creditCard: .constant(PreviewData.shared.creditCard), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData, onSave: {print("")})
}
