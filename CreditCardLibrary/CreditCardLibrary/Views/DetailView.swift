import SwiftUI

struct DetailView: View {
    
    @Bindable var creditCard: CreditCard
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
    
    var body: some View {
        VStack {
            CardView(creditCard: creditCard)
                .frame(width: 486/2, height: 306/2)
                .scaleEffect(0.6)
                .padding(40)
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
            HStack {
                Text("Promotion Name")
                Spacer()
                Text(creditCard.promotion?.name ?? "None")
            }
            HStack {
                Text("Bonus Name")
                Spacer()
                Text(creditCard.bonus?.name ?? "None")
            }
            Spacer()
        }
        .navigationTitle("Credit Card Details")
    }
}

// MARK: Previews

#Preview("Details") {
    DetailView(creditCard: PreviewData.shared.creditCard)
        .modelContainer(PreviewData.shared.modelContainer)
}

