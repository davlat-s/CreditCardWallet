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
                Section("Card Details") {
//                    HStack {
//                        Spacer()
//                        FormCardImageView(cardArt: $cardArt, isShowingImagePicker: $showCardArtPicker)
//                        Spacer()
//                    }
                    
                    HStack {
//                                                DatePickerModifierView(title: "Open Date", selection: $creditCard.openDate, width: 0)
                        VStack {
                            HStack {
                                Spacer()
                                FormCardImageView(cardArt: $cardArt, isShowingImagePicker: $showCardArtPicker)
                                Spacer()
                            }
                            HStack {
                                RequiredTextField(title: "Card Name", text: $creditCard.name, width: .infinity, prompt: "Sapphire Reserve", borderColor: .accent)
                                
                                
                            }
                            
                            
                            HStack {
                                RequiredTextField(title: "Credit Limit",
                                                  text: $creditCard.creditLimit,
                                                  width: 225,
                                                  prompt: creditCard.isChargeCard ? "Not Applicable to Charge Cards" : "$24,000",
                                                  borderColor: .accent,
                                                  variable: !creditCard.isChargeCard
                                        
                                )
                                .disabled(creditCard.isChargeCard)
                                RequiredTextField(title: "Last 4-5 Digits", text: $creditCard.lastDigits, width: .infinity, prompt: "**** **** **** 5032", borderColor: .accent)
                                
                                HStack {
                                    CustomPickerView(title: "Select Bank", options: existingBanks, selection: $bank, isNewBank: $isNewBank, width: 175, borderColor: .accent)
                                }
                                
                            }
                            HStack {
                                DatePickerModifierView(title: "Open Date", selection: $creditCard.openDate, width: 0)
                                FormToggleModifierView(title: "Charge Card", isOn: $creditCard.isChargeCard, width: 100)
                                FormToggleModifierView(title: "Business", isOn: $creditCard.isBusiness, width: 100)
                                
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
            AddBankView(textFieldWidth: $textFieldWidth) { newBank in
                modelContext.insert(newBank)
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
