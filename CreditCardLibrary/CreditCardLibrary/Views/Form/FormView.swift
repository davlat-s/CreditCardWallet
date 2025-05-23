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
    
    var existingBanks: [Bank]
    var paymentProcessors: [PaymentProcessor]
    
    @State private var showCardArtPicker: Bool = false
    
    var body: some View {
        ScrollView {
            Form {
                Section("Card Details") {
                    HStack {
                        VStack {
                            HStack {
                                Spacer()
                                SelectCardImageView(cardArt: $cardArt, isShowingImagePicker: $showCardArtPicker)
                                Spacer()
                            }
                            HStack {
                                CustomTextField(title: "Card Name", text: $creditCard.name, width: .infinity, prompt: "Sapphire Reserve", borderColor: .accent)
                                    .accessibilityLabel("Card Name")
                                    .accessibilityIdentifier("cardNameTextField")
                                CustomNumberField(title: "Annual Fee", number: $creditCard.annualFee, width: 200, prompt: "$495", borderColor: .accent)
                                    .accessibilityLabel("Annual Fee")
                                    .accessibilityIdentifier("annualFeeNumberField")
                            }
                            HStack {
                                CustomNumberField(
                                    title: "Credit Limit",
                                    number: $creditCard.creditLimit,
                                    width: 225,
                                    prompt: creditCard.isChargeCard ? "Not Applicable to Charge Cards" : "$24,000",
                                    borderColor: .accent,
                                    variable: !creditCard.isChargeCard
                                )
                                .disabled(creditCard.isChargeCard)
                                .accessibilityLabel("Credit Limit")
                                .accessibilityIdentifier("creditLimitNumberField")
                                CustomTextField(title: "Last 4-5 Digits", text: $creditCard.lastDigits, width: .infinity, prompt: "**** **** **** 5032", borderColor: .accent)
                                    .accessibilityLabel("Last Four or Five Digits")
                                    .accessibilityIdentifier("lastDigitsTextField")
                                
                                HStack {
                                    CustomPicker(title: "Select Bank", options: existingBanks, selection: $bank, isNewBank: $isNewBank, width: 175, borderColor: .accent)
                                        .accessibilityLabel("Select Bank")
                                        .accessibilityIdentifier("bankPicker")
                                }
                            }
                            HStack {
                                CustomDatePicker(title: "Open Date", selection: $creditCard.openDate, width: 0)
                                    .accessibilityLabel("Open Date")
                                    .accessibilityIdentifier("openDatePicker")
                                CustomToggle(title: "Charge Card", isOn: $creditCard.isChargeCard, width: 100)
                                    .accessibilityLabel("Charge Card")
                                    .accessibilityIdentifier("chargeCardToggle")
                                CustomToggle(title: "Business", isOn: $creditCard.isBusiness, width: 100)
                                    .accessibilityLabel("Business")
                                    .accessibilityIdentifier("businessToggle")
                                
                                Spacer()
                            }
                            .padding(.top, 10)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
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
                        .accessibilityLabel("Add Promotion")
                        .accessibilityIdentifier("addPromotionButton")
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
                        .accessibilityLabel("Add Bonus")
                        .accessibilityIdentifier("addBonusButton")
                    }
                }
                
                Section("Card Status") {
                    if let close = closed?.reason {
                        HStack {
                            Text("Closed: \(close)")
                            Spacer()
                            Button {
                                closed = nil
                            } label: {
                                Label("Open Card", systemImage: "archivebox.fill")
                                    .labelStyle(.titleOnly)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Open Card")
                            .accessibilityIdentifier("openCardButton")
                        }
                    } else {
                        HStack {
                            Text("Active")
                            Spacer()
                            Button {
                                isClosed.toggle()
                            } label: {
                                Label("Close Card", systemImage: "archivebox.fill")
                                    .labelStyle(.titleOnly)
                            }
                            .buttonBorderShape(.roundedRectangle)
                            .accessibilityLabel("Close Card")
                            .accessibilityIdentifier("closeCardButton")
                        }
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
            AddBankView() { newBank in
                modelContext.insert(newBank)
                bank = newBank
            }
        }
        .sheet(isPresented: $isNewPromo) {
            AddPromotionView() { newPromo in
                promotions.append(newPromo)
            }
        }
        .sheet(isPresented : $isNewBonus) {
            AddBonusView() { newBonus in
                bonuses.append(newBonus)
            }
        }
        .sheet(isPresented : $isClosed) {
            CloseCardView() { newClosed in
                closed = newClosed
            }
        }
    }
}
