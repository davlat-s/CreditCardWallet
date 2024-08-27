import SwiftUI

struct CreditCardDetail: View {
    
    @Bindable var creditCard: CreditCard
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(creditCard: CreditCard, isNew: Bool = false) {
        self.creditCard = creditCard
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Card name", text: $creditCard.name)
                .autocorrectionDisabled()
            
        }
        .navigationTitle(isNew ? "New Credit Card" : "Credit Card Details")
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        modelContext.delete(creditCard)
                        dismiss()
                    }
                }
            }
            
        }
    }
}

// MARK: Previews

#Preview("Details") {
    CreditCardDetail(creditCard: SampleData.shared.creditCard)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("isNew") {
    CreditCardDetail(creditCard: SampleData.shared.creditCard, isNew: true)
        .modelContainer(SampleData.shared.modelContainer)
}
