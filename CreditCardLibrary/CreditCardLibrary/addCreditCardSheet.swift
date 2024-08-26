//import SwiftUI
//import SwiftData
//
//struct addCreditCardSheet: View {
//    @Environment(\.modelContext) var context
//    @Environment(\.dismiss) private var dismiss
//        
//    @State var cardName: String = ""
//    @State var newBankName: String = ""
//    @State var openDate: Date = .now
//    @State var lastDigits: String = ""
//    @State var annualFee: Int = 0
//    @State var dueDay: Int = 0
//    @State var creditLimit: Double = 0
//    @State var isChargeCard: Bool = false
//    @State var isBusiness: Bool = false
//    @State var isClosed: Bool = false
//    @State var hasBonus: Bool = false
//    @State var hasPromotion: Bool = false
//    @State var imageName: String = "default"
//    
//    @State var selectedBank: Bank? = nil
//    @Query var existingBanks : [Bank]
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                TextField("Card Name", text: $cardName)
//                
//                Picker("Bank", selection: $selectedBank){
//                    ForEach(existingBanks){ bank in
//                        Text(bank.name).tag(Optional(bank))
//                    }
//                    Text("Other").tag(Optional<Bank>(nil))
//                }
//                
//                if selectedBank == nil {
//                    TextField("Bank Name", text: $newBankName)
//                }
//                
//                DatePicker("Open Date", selection: $openDate, displayedComponents: .date)
//                TextField("Last Digits", text: $lastDigits)
//                TextField("Annual Fee", value: $annualFee, format: .number)
//                TextField("Due Day", value: $dueDay, format: .number)
//                TextField("Credit Limit", value: $creditLimit, format: .number)
//                Toggle("Charge Card", isOn: $isChargeCard)
//                Toggle("Business", isOn: $isBusiness)
//                Toggle("Closed", isOn: $isClosed)
//                Toggle("Sign up bonus", isOn: $hasBonus)
//                Toggle("APR promotion", isOn: $hasPromotion)
//                TextField("Image name", text: $imageName)
//            }
//            .navigationTitle("New Card")
//            .toolbar {
//                ToolbarItemGroup {
//                    Button("Cancel"){dismiss()}
//                    Button("Save") {
//                        // Create or find the bank
//                        var bank : Bank
//                        
//                        if let unwrappedBank = selectedBank {
//                            bank = unwrappedBank
//                        }else {
//                            bank = Bank(name: newBankName)
//                        }
//                        
//                        // Create the credit card with all properties initialized
//                        let card = CreditCard(cardName: cardName, bank: bank, openDate: openDate, lastFourDigits: lastDigits, annualFee: annualFee, dueDay: dueDay, isChargeCard: isChargeCard, isBusiness: isBusiness, imageName: imageName)
//                                                
//                        context.insert(card)
//                        
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    addCreditCardSheet()
//}
