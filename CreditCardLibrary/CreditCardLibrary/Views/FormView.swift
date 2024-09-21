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
    
    @State var isNewBank: Bool
    @State var isNewPromo: Bool = false
    @State var isNewBonus: Bool = false
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var onSave: () -> Void
    
    var body: some View {
        Form {
            TextField("Card Name", text: $cardName)
            TextField("Last Digits", text: $lastDigits)
            
            Toggle("Business", isOn: $isBusiness)

            Picker("Payment Processor", selection: $selectedPP) {
                ForEach(paymentProcessors) { pp in
                    Text(pp.name).tag(Optional(pp))
                }
            }
            if !existingBanks.isEmpty {
                Picker("Bank", selection: $selectedBank) {
                    ForEach(existingBanks) { bank in
                        Text(bank.name).tag(Optional(bank))
                    }
                }
            }
            

            Toggle("New Bank", isOn: $isNewBank)

            if isNewBank {
                AddBankView { newBank in
                    modelContext.insert(newBank)
                    selectedBank = newBank
                }
            }
            HStack {
                Text("Promotion:")
                Spacer()
                Text(promotion?.name ?? "None")
            }
            Toggle("New Promo", isOn: $isNewPromo)
            
            if isNewPromo {
                AddPromotionView { newPromo in
                    modelContext.insert(newPromo)
                    promotion = newPromo
                }
            }
            
            HStack {
                Text("Bonus")
                Spacer()
                Text(bonus?.name ?? "None")
            }
            
            Toggle("New Bonus", isOn: $isNewBonus)
            
            if isNewBonus {
                AddBonusView { newBonus in
                    modelContext.insert(newBonus)
                    bonus = newBonus
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
             promotion: .constant(SampleData.shared.promotion),
             selectedBank:.constant(SampleData.shared.bank),
             bonus: .constant(SampleData.shared.bonus),
             selectedPP: .constant(SampleData.shared.paymentProcessor),
             isNewBank: false,
             existingBanks: Bank.sampleData,
             paymentProcessors: PaymentProcessor.sampleData,
             onSave: {print("yay")})
}
