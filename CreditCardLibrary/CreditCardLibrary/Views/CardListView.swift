import SwiftUI
import SwiftData

struct CardListView: View {

    @Binding var selectedCategory: SideBarCategories
    @Binding var selectedCard: CreditCard?
    
    @Query(sort: \CreditCard.name) private var cards: [CreditCard]
    
    var filteredCreditCards: [CreditCard] {
        cards.filter(selectedCategory.sidebarFilter)
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
                .buttonStyle(.plain)
            } else {
                Text("No cards available")
            }
        }
    }

    init(searchString: String = "", selectedCard: Binding<CreditCard?>, selectedCategory: Binding<SideBarCategories>) {
        _selectedCard = selectedCard
        _selectedCategory = selectedCategory
        _cards = Query(filter: #Predicate { card in
            if searchString.isEmpty {
                return true
            } else {
                return card.name.localizedStandardContains(searchString)
            }
        })
    }
}

// MARK: Previews
#Preview("Open") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.open)
    )
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Personal") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.personal)
    )
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Business") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.business)
    )
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Closed") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.closed)
    )
    .modelContainer(SampleData.shared.modelContainer)
}
