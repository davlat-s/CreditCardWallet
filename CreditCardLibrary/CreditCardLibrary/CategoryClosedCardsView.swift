import SwiftUI

struct CategoryClosedCardsView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filteredCards: modelData.closedCardList, emptymessage: "No closed cards available")
    }
}


#Preview {
    CategoryClosedCardsView()
        .environment(ModelData())
}
