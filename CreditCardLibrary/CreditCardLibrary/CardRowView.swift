import SwiftUI

struct CardRowView: View {
    var creditcard: CreditCard
    
    var body: some View {
        HStack {
            creditcard.image
                .resizable()
                .frame(width: 65, height: 40)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 5)))
                
            Text(creditcard.cardName)
                .padding()
                .fixedSize(horizontal: true, vertical: true)
            
        }
        .frame(width: 300, alignment: .leading)
    }
}

#Preview {
    CardRowView(creditcard: CreditCard(id: "34255", cardName: "Platinum", bankName: "Chase", openDate: Date(), annualFee: 0, dueDay: 12, creditLimit: 12000.0, isChargeCard: false, isBusiness: false, isClosed: false, wasDowngraded: false, hasAPRPromotion: false, hasBonusPromotion: false, imageName: "1"))
}
