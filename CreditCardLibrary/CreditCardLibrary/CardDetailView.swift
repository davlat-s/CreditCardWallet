//import SwiftUI
//
//struct CardDetailView: View {
//    
//    var creditcard: CreditCard
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .center) {
//                CardImageView(image: creditcard.image)
//                RowDetailViewHelper(rowName: "Annual Fee", rowValue: String("$\(creditcard.annualFee)"))
//                RowDetailViewHelper(rowName: "Credit Limit", rowValue: String("$\(Int(creditcard.creditLimit ?? 0))"))
////                RowDetailViewHelper(rowName: "Open Date", rowValue: creditcard.formattedDate(  date: creditcard.openDate))
//            }
//        }
//    }
//}
//
//#Preview {
//    CardDetailView(creditcard: CreditCard(cardName: "ink", bank: Bank(name: "Chase"), openDate: .now, lastFourDigits: "3243", annualFee: 0, dueDay: 4, isChargeCard: false, isBusiness: false, imageName: "default"))
//
//}
