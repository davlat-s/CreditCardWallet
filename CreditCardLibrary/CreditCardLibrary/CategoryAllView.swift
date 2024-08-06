import SwiftUI

struct CategoryAllView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        if filteredCreditCards.isEmpty {
            Text("No open cards available")
        } else {
            CategoryViewHelper(filteredCreditCards: filteredCreditCards)
            }
        }
    
    var filteredCreditCards: [CreditCard] {
        modelData.creditCardList.filter { card in !card.isClosed}
    }
}

#Preview {
    CategoryAllView()
        .environment(ModelData())
}
