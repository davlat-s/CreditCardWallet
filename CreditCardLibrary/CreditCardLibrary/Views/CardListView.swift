import SwiftUI
import SwiftData

struct CardListView: View {

    @Binding var selectedCategory: Category
    @Binding var selectedCard: CreditCard?
    
    
    @Query(sort: \CreditCard.name) private var allCreditCards: [CreditCard]
    
    var filteredCreditCards: [CreditCard] {
        allCreditCards.filter(selectedCategory.sidebarFilter)
    }
    
    var body: some View {
        List(filteredCreditCards, selection: $selectedCard) { card in
            NavigationLink(value: card) {
                Text(card.name)
            }
        }
    }
}

// MARK: Previews

#Preview("Open") {
    CardListView(selectedCategory: .constant(.open), selectedCard: .constant(nil))
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Personal") {
    CardListView(selectedCategory: .constant(.personal), selectedCard: .constant(nil))
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Business") {
    CardListView(selectedCategory: .constant(.business), selectedCard: .constant(nil))
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Closed") {
    CardListView(selectedCategory: .constant(.closed), selectedCard: .constant(nil))
        .modelContainer(SampleData.shared.modelContainer)
}
