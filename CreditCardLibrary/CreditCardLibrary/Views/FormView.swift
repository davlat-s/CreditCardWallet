import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Binding var cardName: String
    @Binding var isBusiness: Bool
    @Binding var lastDigits: String
    
    @Binding var promotion: Promotion?
    @Binding var selectedBank: Bank?
    @Binding var bonus: Bonus?
    @Binding var selectedPP: PaymentProcessor?
    @Binding var selectedColor: Color?
    
    @State var isNewBank: Bool
    @State var isNewPromo: Bool = false
    @State var isNewBonus: Bool = false
    @State var textFieldWidth: CGFloat = 236
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var onSave: () -> Void
    
    var body: some View {
        ScrollView {
                Form {
                    ColorPicker("Card Color", selection: Binding(
                        get: { selectedColor ?? Color.gray },
                        set: { newColor in
                            selectedColor = newColor
                        }
                    ))
                    .padding(.top, 20)
                    
                    TextField("Card Name", text: $cardName)
                        .textContentType(.creditCardName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Last Digits", text: $lastDigits)
                        .textContentType(.creditCardNumber)
                        .textFieldStyle(.roundedBorder)
                    
                    Toggle("Business", isOn: $isBusiness)

                    Picker("Payment Processor", selection: $selectedPP) {
                        ForEach(paymentProcessors) { pp in
                            Text(pp.name).tag(Optional(pp))
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.leading, 20)
                    Divider()
                    if !existingBanks.isEmpty {
                        Picker("Bank", selection: $selectedBank) {
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
                            selectedBank = newBank
                        }
                    }
                    Divider()
                    Text(promotion?.name ?? "No Promotions")
                    
                    Toggle("New Promo", isOn: $isNewPromo)
                    
                    if isNewPromo {
                        AddPromotionView(textFieldWidth: $textFieldWidth) { newPromo in
                            modelContext.insert(newPromo)
                            promotion = newPromo
                        }
                    }
                    Divider()
                    Text(bonus?.name ?? "No Bonuses")
                    
                    Toggle("New Bonus", isOn: $isNewBonus)
                    
                    if isNewBonus {
                        AddBonusView(textFieldWidth: $textFieldWidth) { newBonus in
                            modelContext.insert(newBonus)
                            bonus = newBonus
                        }
                    }
                    if isNewBonus {
                        AddBonusView(textFieldWidth: $textFieldWidth) { newBonus in
                            modelContext.insert(newBonus)
                            bonus = newBonus
                        }
                    }
                    if isNewBonus {
                        AddBonusView(textFieldWidth: $textFieldWidth) { newBonus in
                            modelContext.insert(newBonus)
                            bonus = newBonus
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
                .disabled(cardName.isEmpty || selectedBank == nil || selectedPP == nil)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FormView(cardName: .constant(""),
             isBusiness: .constant(false),
             lastDigits: .constant(""),
             promotion: .constant(PreviewData.shared.promotion),
             selectedBank:.constant(PreviewData.shared.bank),
             bonus: .constant(PreviewData.shared.bonus),
             selectedPP: .constant(PreviewData.shared.paymentProcessor),
             selectedColor: .constant(.gray),
             isNewBank: false,
             existingBanks: Bank.sampleData,
             paymentProcessors: PaymentProcessor.sampleData,
             onSave: {print("yay")})
}
