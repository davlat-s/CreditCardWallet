//import SwiftUI
//
//struct CardRowView: View {
//    var creditcard: CreditCard
//    
//    var body: some View {
//        HStack {
//            creditcard.image
//                .resizable()
//                .frame(width: 65, height: 40)
//                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 5)))
//                
//            Text(creditcard.cardName)
//                .padding()
//                .fixedSize(horizontal: true, vertical: true)
//            
//        }
//        .frame(width: 300, alignment: .leading)
//    }
//}
//
//#Preview {
//    CardRowView(creditcard: CreditCard(cardName: "ink", bank: Bank(name: "Chase"), openDate: .now, lastFourDigits: "3243", annualFee: 0, dueDay: 4, isChargeCard: false, isBusiness: false, imageName: "default"))
//}
