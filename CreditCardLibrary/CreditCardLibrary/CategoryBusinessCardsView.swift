import SwiftUI

struct CategoryBusinessCardsView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filteredCards: modelData.businessCardList, emptymessage: "No active business cards available")
    }
}

#Preview {
    CategoryBusinessCardsView()
        .environment(ModelData())
}
