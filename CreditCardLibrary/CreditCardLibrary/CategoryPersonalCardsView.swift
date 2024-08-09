import SwiftUI

struct CategoryPersonalCardsView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filteredCards: modelData.personalCardList, emptymessage: "No active personal cards available")
    }
}

#Preview {
    CategoryPersonalCardsView()
        .environment(ModelData())
}
