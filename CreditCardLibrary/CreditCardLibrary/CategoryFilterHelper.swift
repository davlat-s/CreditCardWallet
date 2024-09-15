//import SwiftUI
//
//struct CategoryFilterHelper: View {
//    
//    var filteredCards: [CreditCard]
//    var emptymessage: String
//    
//    @Environment(
//        \.modelContext
//    ) var context
//    
//    var body: some View {
//        if filteredCards.isEmpty {
//            return AnyView(
//                ContentUnavailableView(label: {
//                    Label(
//                        emptymessage,
//                        systemImage: "creditcard").font(.title3)}))
//        } else {
//            return AnyView(
//                CategoryViewHelper(
//                    filteredCreditCards: filteredCards
//                )
//            )
//        }
//    }
//    
//}
//
//#Preview {
//    CategoryFilterHelper(
//        filteredCards:[CreditCard(cardName: "ink", bank: Bank(name: "Chase"), openDate: .now, lastFourDigits: "3243", annualFee: 0, dueDay: 4, isChargeCard: false, isBusiness: false, imageName: "default")],
//        emptymessage: "Error"
//    )
//}
