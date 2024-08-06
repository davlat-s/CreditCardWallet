import SwiftUI

struct CategoryViewHelper: View {
    
    @Environment(ModelData.self) private var modelData
    
    var filteredCreditCards: [CreditCard]
    
    var body: some View {
        List(filteredCreditCards) {creditcard in NavigationLink(destination: CardDetailView(creditcard: creditcard)) {
            CardRowView(creditcard: creditcard)
        }
        }
        .frame(minWidth: 300)
    }
}

#Preview {
    CategoryViewHelper(filteredCreditCards: ModelData().creditCardList)
        .environment(ModelData())
}
