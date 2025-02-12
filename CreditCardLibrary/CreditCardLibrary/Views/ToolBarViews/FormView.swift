import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var creditCard: CreditCard
    @State var isNewBank: Bool = false
    @State var isNewPromo: Bool = false
    @State var isNewBonus: Bool = false
    @State var isClosed: Bool = false
    @State var textFieldWidth: CGFloat = 236

    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    var onSave: () -> Void
    var onCancel: (() -> Void)? = nil

    /// New state to control the presentation of the CardArt picker.
    @State private var showCardArtPicker: Bool = false

    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("Card Art")) {
                    HStack {
                        Spacer()
                        
                        if let cardArt = creditCard.cardArt {
                            Image(cardArt.assetID)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .clipShape(.rect(cornerRadius: 8))

                        } else {
                            Text("Select Image")
                                .foregroundColor(.secondary)
                                .font(.system(size: 20))
                        }
                        
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Images") {
                            showCardArtPicker = true
                        }                        
                    }
                }

                Section {
                    DatePicker("Open Date", selection: $creditCard.openDate, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                    
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
                        Text("Select").tag(Optional<PaymentProcessor>(nil))
                        ForEach(paymentProcessors) { pp in
                            Text(pp.name).tag(Optional(pp))
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section {
                    Picker("Bank", selection: $creditCard.bank) {
                        Text("Select").tag(Optional<Bank>(nil))
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
                
                Section {
                    Text(creditCard.promotion?.details ?? "No Promotions")
                    Toggle("New Promo", isOn: $isNewPromo)
                    
                    if isNewPromo {
                        AddPromotionView(textFieldWidth: $textFieldWidth) { newPromo in
                            modelContext.insert(newPromo)
                            creditCard.promotion = newPromo
                        }
                    }
                }
                
                Section {
                    Text(creditCard.bonus?.details ?? "No Bonuses")
                    Toggle("New Bonus", isOn: $isNewBonus)
                    
                    if isNewBonus {
                        AddBonusView(textFieldWidth: $textFieldWidth) { newBonus in
                            modelContext.insert(newBonus)
                            creditCard.bonus = newBonus
                        }
                    }
                }
                
                Section {
                    Text(creditCard.closed?.reason ?? "Open")
                    Toggle("Close Card", isOn: $isClosed)
                    
                    if isClosed {
                        AddClosedView(textFieldWidth: $textFieldWidth) { newClosed in
                            modelContext.insert(newClosed)
                            creditCard.closed = newClosed
                        }
                    }
                }
                
                
            }
            .formStyle(.grouped)
        }
        // Present the CardArtPicker sheet.
        .sheet(isPresented: $showCardArtPicker) {
            CardImagePickerView(selectedCardArt: $creditCard.cardArt)
                .frame(width: 800)
                .frame(minHeight: 600, idealHeight: 650, maxHeight: 700)
        }
    }
}


#Preview {
    FormView(creditCard: .constant(PreviewData.shared.creditCard),
             existingBanks: Bank.sampleData,
             paymentProcessors: PaymentProcessor.sampleData,
             onSave: { print("Saved") })
        .frame(height: 1000)
}
