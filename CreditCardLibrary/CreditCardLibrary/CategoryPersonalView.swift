import SwiftUI

struct CategoryPersonalView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        if filteredCreditCards.isEmpty {
            Text("No personal cards available")
        } else {
            CategoryViewHelper(filteredCreditCards: filteredCreditCards)
            }
        }
    var filteredCreditCards: [CreditCard] { modelData.creditCardList.filter { card in !card.isBusiness && !card.isClosed}
    }
}

#Preview {
    CategoryPersonalView()
        .environment(ModelData())
}
