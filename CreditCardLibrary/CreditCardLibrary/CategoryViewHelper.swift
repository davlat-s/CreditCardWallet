import SwiftUI

struct CategoryViewHelper: View {
        
    var filteredCreditCards: [CreditCard]
    
    var body: some View {
        List(filteredCreditCards) {creditcard in NavigationLink(destination: CardDetailView(creditcard: creditcard)) {
            CardRowView(creditcard: creditcard)
        }
        }
        .frame(minWidth: 300)
    }
}

#Preview {
    CategoryViewHelper(filteredCreditCards: [CreditCard(id: "34255", cardName: "Platinum", bankName: "Chase", openDate: Date(), annualFee: 0, dueDay: 12, creditLimit: 12000.0, isChargeCard: false, isBusiness: false, isClosed: false, wasDowngraded: false, hasAPRPromotion: false, hasBonusPromotion: false, imageName: "1")])
}
