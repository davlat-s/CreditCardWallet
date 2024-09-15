//
//  AddCreditCardView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 9/13/24.
//

import SwiftUI
import SwiftData

struct AddCreditCardView: View {
    
    var creditCard: CreditCard
    var existingBanks: [Bank]

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var cardName: String = ""
    @State var isBusiness: Bool = false
    @State var isNewBank: Bool = false
    @State var selectedBank: Bank?
    
    var body: some View {
        Form {
            TextField("Card Name", text: $cardName)
            Toggle(isOn: $isBusiness, label: {Text("Business")})
            
            if !existingBanks.isEmpty {
                Picker("Bank", selection: $selectedBank){
                    ForEach(existingBanks){ bank in
                        Text(bank.name).tag(Optional(bank))
                    }
                }
            }
            
            Toggle(isOn: $isNewBank, label: {Text("Add Bank")})
            
            if isNewBank {
                AddBankView { newBank in
                    modelContext.insert(newBank)
                    selectedBank = newBank
                    creditCard.bank = newBank
                }
            }
        
            HStack {
                Button("Save") {
                    creditCard.name = cardName
                    creditCard.isBusiness = isBusiness
                    creditCard.bank = selectedBank
                    
                    modelContext.insert(creditCard)
                    dismiss()
                }
                .disabled(cardName.isEmpty || selectedBank == nil)
                
                
                Button("Cancel") {
                    dismiss()
                }
                
                .onChange(of: selectedBank) { oldBank, newBank in
                    if selectedBank == nil {
                        isNewBank = true
                    } else {
                        creditCard.bank = selectedBank
                        isNewBank = false
                    }
            }
            }
        }
        .onAppear {
            if existingBanks.isEmpty {
                isNewBank = true
            }
        }
    }
}


#Preview {
    AddCreditCardView(creditCard: SampleData.shared.creditCard, existingBanks: Bank.sampleData)
}
