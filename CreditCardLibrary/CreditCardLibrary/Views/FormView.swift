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
    var onCancel: (() -> Void)? = nil
    
    var body: some View {
        ScrollView {
            Form {
                HStack {
                    Spacer()
                    CardView(creditCard: creditCard)
                        .scaleEffect(0.45)
                        .frame(width: CreditCard.cardWidth/4, height: CreditCard.cardHeight/4)
                        .padding(50)
                    Spacer()
                }

                Section() {
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
                }

                Section() {
                    Picker("Bank", selection: $creditCard.bank) {
                        ForEach(existingBanks) { bank in
                            Text(bank.name).tag(Optional(bank))
                        }
                    }
                    .pickerStyle(.menu)
                    Toggle("New Bank", isOn: $isNewBank)
                    
                    if isNewBank {
                        AddBankView(textFieldWidth: $textFieldWidth) { newBank in
                            modelContext.insert(newBank)
                            creditCard.bank = newBank
                        }
                    }
                }
                
                Section() {
                    Text(creditCard.promotion?.name ?? "No Promotions")
                    Toggle("New Promo", isOn: $isNewPromo)
                    
                    if isNewPromo {
                        AddPromotionView(textFieldWidth: $textFieldWidth) { newPromo in
                            modelContext.insert(newPromo)
                            creditCard.promotion = newPromo
                        }
                    }
                }
                
                Section() {
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
            .formStyle(.grouped)
        }
    }
}


#Preview {
    FormView(creditCard: .constant(PreviewData.shared.creditCard), existingBanks: Bank.sampleData, paymentProcessors: PaymentProcessor.sampleData, onSave: {print("")})
        .frame(height: 1000)
}
