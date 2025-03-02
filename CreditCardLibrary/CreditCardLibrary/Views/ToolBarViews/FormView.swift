import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var creditCard: CreditCard
    @Binding var bank: Bank?
    @Binding var promotions: [Promotion]
    @Binding var bonuses: [Bonus]
    @Binding var closed: Closed?
    @Binding var cardArt: CardArt?
    @Binding var paymentProcessor: PaymentProcessor?
    
    
    @State var isNewBank: Bool = false
    @State var isNewPromo: Bool = false
    @State var isNewBonus: Bool = false
    @State var isClosed: Bool = false
    @State var textFieldWidth: CGFloat = 236

    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    @State private var showCardArtPicker: Bool = false

    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("Card Art")) {
                    HStack {
                        Spacer()
                        if let cardArt = cardArt {
                            Image(cardArt.assetID)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Text("Select Image")
                                .foregroundColor(.secondary)
                                .font(.system(size: 20))
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            showCardArtPicker = true
                        }) {
                            Label("Choose Card Image", systemImage: "photo")
                        }
                        Spacer()
                    }
                }
                
                Section("Card Details") {
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
                    
                    if !creditCard.isChargeCard {
                        TextField("Credit Limit", text: $creditCard.creditLimit)
                            .textFieldStyle(.roundedBorder)
                    } else {
                        
                        Text("Credit Limit is not applicable for Charge Cards")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                    Toggle("Business", isOn: $creditCard.isBusiness)
                    
                    Picker("Payment Processor", selection: $paymentProcessor) {
                        Text("Select").tag(Optional<PaymentProcessor>(nil))
                        ForEach(paymentProcessors) { pp in
                            Text(pp.name).tag(Optional(pp))
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Bank") {
                    Picker("Bank", selection: $bank) {
                        Text("Select").tag(Optional<Bank>(nil))
                        ForEach(existingBanks) { bank in
                            Text(bank.name).tag(Optional(bank))
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack {
                        Spacer()
                        Button {
                            isNewBank.toggle()
                        }label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                    }

                }
                
                Section("Promotions") {
                    ForEach(promotions){promo in
                        HStack {
                            Text(promo.details)
                        }
                    }
                    HStack {
                        Spacer()
                        Button {
                            isNewPromo.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                    }

                }
                
                Section("Bonuses") {
                    ForEach(bonuses){bonus in
                        HStack {
                            Text(bonus.details)
                        }
                    }
                    HStack {
                        Spacer()
                        Button {
                            isNewBonus.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                    }

                }
                
                Section("Card Status") {
                    Text(closed?.reason ?? "Open")
                    HStack {
                        Spacer()
                        Button {
                            isClosed.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                
            }
            .formStyle(.grouped)
        }
        .sheet(isPresented: $showCardArtPicker) {
            CardImagePickerView(selectedCardArt: $cardArt)
                .frame(width: 700, height: 650)
        }
        .sheet(isPresented: $isNewBank) {
            AddBankView(textFieldWidth: $textFieldWidth) { newBank in
                bank = newBank
            }
        }
        .sheet(isPresented: $isNewPromo) {
            AddPromotionView(textFieldWidth: $textFieldWidth) { newPromo in
                promotions.append(newPromo)
            }
        }
        .sheet(isPresented : $isNewBonus) {
            AddBonusView(textFieldWidth: $textFieldWidth) { newBonus in
                bonuses.append(newBonus)
            }
        }
        .sheet(isPresented : $isClosed) {
            AddClosedView(textFieldWidth: $textFieldWidth) { newClosed in
                closed = newClosed
            }
        }
    }
}


//#Preview {
//    FormView(creditCard: .constant(PreviewData.shared.creditCard),
//             bank: .constant(PreviewData.shared.bank),
//             promotions: .constant(PreviewData.shared.promotion),
//             bonus: .constant(PreviewData.shared.bonus),
//             closed: .constant(PreviewData.shared.closed),
//             cardArt: .constant(CardArt.sampleData[0]),
//             paymentProcessor: .constant(PreviewData.shared.paymentProcessor),
//             existingBanks: Bank.sampleData,
//             paymentProcessors: PaymentProcessor.sampleData)
//        .frame(height: 1000)
//}
