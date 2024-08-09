import SwiftUI

struct CategoryFilterHelper: View {
    
    var filteredCards: [CreditCard]
    var emptymessage: String
    
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        if filteredCards.isEmpty {
            return AnyView(Text(emptymessage))
        } else {
            return AnyView(CategoryViewHelper(filteredCreditCards: filteredCards))
        }
    }
    
}

#Preview {
    CategoryFilterHelper(filteredCards: ModelData().businessCardList,  emptymessage: "test")
        .environment(ModelData())
}
