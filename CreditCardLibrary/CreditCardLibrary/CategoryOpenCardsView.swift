import SwiftUI
import SwiftData

struct CategoryOpenCardsView: View {
    var creditCards: [CreditCard] = [CreditCard(id: "34255", cardName: "Platinum", bankName: "Chase", openDate: Date(), annualFee: 0, dueDay: 12, creditLimit: 12000.0, isChargeCard: false, isBusiness: false, isClosed: false, wasDowngraded: false, hasAPRPromotion: false, hasBonusPromotion: false, imageName: "1")]
    
    var body: some View {
        CategoryFilterHelper(filteredCards: creditCards, emptymessage: "No active cards available")
    }
}

#Preview {
    CategoryOpenCardsView()
}
