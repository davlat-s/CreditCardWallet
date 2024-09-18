import SwiftUI
import SwiftData

struct CardListView: View {

    @Binding var selectedCategory: SideBarCategories
    @Binding var selectedCard: CreditCard?
    
    
    @Query(sort: \CreditCard.name) private var allCreditCards: [CreditCard]
    
    var filteredCreditCards: [CreditCard] {
        allCreditCards.filter(selectedCategory.sidebarFilter)
    }
    
    var body: some View {
        Group {
            if !filteredCreditCards.isEmpty {
                List(filteredCreditCards, selection: $selectedCard) { card in
                    NavigationLink(value: card) {
                        HStack {
                            CardView(creditCard: card)
                                .frame(width: 48.6, height: 30.6)
                                .scaleEffect(0.15)
                                .padding(20)
                            Text(card.name)
                        }
                    }
                }
            } else {
                Text("No cards available")
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

