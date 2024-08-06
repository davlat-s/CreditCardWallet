import SwiftUI

struct CategoryFilterHelper: View {
    
    var filter: (CreditCard) -> Bool
    var emptymessage: String
    
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        let filteredCards = modelData.creditCardList.filter(filter)
        if filteredCards.isEmpty {
            return AnyView(Text(emptymessage))
        } else {
            return AnyView(CategoryViewHelper(filteredCreditCards: filteredCards))
        }
    }
    
}

#Preview {
    CategoryFilterHelper(filter: {$0.isBusiness}, emptymessage: "test")
        .environment(ModelData())
}
