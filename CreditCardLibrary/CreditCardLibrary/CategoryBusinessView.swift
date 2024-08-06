import SwiftUI

struct CategoryBusinessView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        if filteredCreditCards.isEmpty {
            Text("No business cards available")
        } else {
            CategoryViewHelper(filteredCreditCards: filteredCreditCards)
            }
        }
    
    var filteredCreditCards: [CreditCard] {
        modelData.creditCardList.filter { card in card.isBusiness && !card.isClosed}
    }
}

#Preview {
    CategoryBusinessView()
        .environment(ModelData())
}
