//import SwiftUI
//
//struct CategoryViewHelper: View {
//        
//    var filteredCreditCards: [CreditCard]
//    
//    var body: some View {
//        List(filteredCreditCards) {creditcard in NavigationLink(destination: CardDetailView(creditcard: creditcard)) {
//            CardRowView(creditcard: creditcard)
//        }
//        }
//        .frame(minWidth: 300)
//    }
//}
//
//#Preview {
//    CategoryViewHelper(filteredCreditCards: [CreditCard(cardName: "ink", bank: Bank(name: "Chase"), openDate: .now, lastFourDigits: "3243", annualFee: 0, dueDay: 4, isChargeCard: false, isBusiness: false, imageName: "default")])
//}
