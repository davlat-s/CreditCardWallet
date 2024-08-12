import SwiftUI

struct CardDetailView: View {
    
    var creditcard: CreditCard
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CardImageView(image: creditcard.image)
                RowDetailViewHelper(rowName: "Annual Fee", rowValue: String("$\(creditcard.annualFee)"))
                RowDetailViewHelper(rowName: "Credit Limit", rowValue: String("$\(Int(creditcard.creditLimit))"))
//                RowDetailViewHelper(rowName: "Open Date", rowValue: creditcard.formattedDate(  date: creditcard.openDate))
            }
        }
    }
}

#Preview {
    CardDetailView(creditcard: CreditCard(id: "34255", cardName: "Platinum", bankName: "Chase", openDate: Date(), annualFee: 0, dueDay: 12, creditLimit: 12000.0, isChargeCard: false, isBusiness: false, isClosed: false, wasDowngraded: false, hasAPRPromotion: false, hasBonusPromotion: false, imageName: "1"))

}
