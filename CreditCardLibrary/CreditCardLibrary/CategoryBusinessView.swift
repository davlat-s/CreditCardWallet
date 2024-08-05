import SwiftUI

struct CategoryBusinessView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        List(filteredCreditCards) {creditcard in CardRowView(creditcard: creditcard)
        }
    }
    
    var filteredCreditCards: [CreditCard] {
        modelData.creditCardList.filter { card in card.isBusiness}
    }
}

#Preview {
    CategoryBusinessView()
        .environment(ModelData())
}
