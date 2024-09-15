import SwiftUI

struct CreditCardDetail: View {
    
    @Bindable var creditCard: CreditCard
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("CardName")
                Spacer()
                Text(creditCard.name)
            }
            HStack {
                Text("Type")
                Spacer()
                Text(creditCard.isBusiness ? "Business" : "Personal")
            }
            HStack {
                Text("Bank Name")
                Spacer()
                Text(creditCard.bank?.name ?? "No Bank")
            }
        }
        .navigationTitle("Credit Card Details")
    }
}

// MARK: Previews

#Preview("Details") {
    CreditCardDetail(creditCard: SampleData.shared.creditCard)
        .modelContainer(SampleData.shared.modelContainer)
}

