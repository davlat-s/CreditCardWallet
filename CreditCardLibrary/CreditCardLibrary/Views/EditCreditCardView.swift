import SwiftUI

struct EditCreditCardView: View {
    var creditCard: CreditCard? // Optional CreditCard passed in, not as Binding
    var existingBanks: [Bank]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    // Local state for editing
    @State private var cardName: String
    @State private var isBusiness: Bool
    @State private var bank: Bank?
    
    // Initializer that sets the local state based on the incoming CreditCard
    init(creditCard: CreditCard?, existingBanks: [Bank]) {
        self.creditCard = creditCard
        self.existingBanks = existingBanks
        
        // Set default values if creditCard is nil
        _cardName = State(initialValue: creditCard?.name ?? "")
        _isBusiness = State(initialValue: creditCard?.isBusiness ?? false)
        _bank = State(initialValue: creditCard?.bank)
    }
    
    var body: some View {
        Form {
            TextField("Card Name", text: $cardName)
            Toggle("Business Card", isOn: $isBusiness)
            
            // Bank Picker
            Picker("Bank", selection: $bank) {
                Text("None").tag(Bank?.none)
                ForEach(existingBanks, id: \.self) { bank in
                    Text(bank.name).tag(Optional(bank))
                }
            }
            
            HStack {
                Button("Save Changes") {
                    saveChanges()
                }
                .disabled(cardName.isEmpty || bank == nil)
                
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
    
    // Saving the changes
    private func saveChanges() {
        if var card = creditCard {
            card.name = cardName
            card.isBusiness = isBusiness
            card.bank = bank
        } else {
            // Handle case if new card is being created
            let newCard = CreditCard(name: cardName, isBusiness: isBusiness, bank: bank)
            modelContext.insert(newCard)
        }
        dismiss()
    }
}
