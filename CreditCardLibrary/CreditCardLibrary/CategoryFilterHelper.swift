import SwiftUI

struct CategoryFilterHelper: View {
    
    var filteredCards: [CreditCard]
    var emptymessage: String
    
    @Environment(
        \.modelContext
    ) var context
    
    var body: some View {
        if filteredCards.isEmpty {
            return AnyView(
                ContentUnavailableView(label: {
                    Label(
                        emptymessage,
                        systemImage: "creditcard").font(.title3)}))
        } else {
            return AnyView(
                CategoryViewHelper(
                    filteredCreditCards: filteredCards
                )
            )
        }
    }
    
}

#Preview {
    CategoryFilterHelper(
        filteredCards:[CreditCard(
            id: "34255",
            cardName: "Platinum",
            bankName: "Chase",
            openDate: Date(),
            annualFee: 0,
            dueDay: 12,
            creditLimit: 12000.0,
            isChargeCard: false,
            isBusiness: false,
            isClosed: false,
            wasDowngraded: false,
            hasAPRPromotion: false,
            hasBonusPromotion: false,
            imageName: "1"
        )],
        emptymessage: "Error"
    )
}
