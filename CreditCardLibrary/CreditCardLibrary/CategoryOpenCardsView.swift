import SwiftUI

struct CategoryOpenCardsView: View {
    
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filteredCards: modelData.openCardList, emptymessage: "No active cards available")
    }
}

#Preview {
    CategoryOpenCardsView()
        .environment(ModelData())
}
