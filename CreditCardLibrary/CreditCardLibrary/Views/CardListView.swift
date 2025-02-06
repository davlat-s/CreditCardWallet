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
                            CardRowView(creditCard: card)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .animation(.easeInOut, value: filteredCreditCards)
                .buttonStyle(.plain)
            } else {
                Text("No cards available")
            }
        }
    }

    init(searchString: String = "", sortOrder: [SortDescriptor<CreditCard>] = [], selectedCard: Binding<CreditCard?>, selectedCategory: Binding<SideBarCategories>) {
        _selectedCard = selectedCard
        _selectedCategory = selectedCategory
        _cards = Query(filter: #Predicate { card in
            if searchString.isEmpty {
                return true
            } else {
                return card.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
}

// MARK: Previews
#Preview("Open") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.all)
    )
    .modelContainer(PreviewData.shared.modelContainer)
}

#Preview("Personal") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.personal)
    )
    .modelContainer(PreviewData.shared.modelContainer)
}

#Preview("Business") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.business)
    )
    .modelContainer(PreviewData.shared.modelContainer)
}

#Preview("Closed") {
    CardListView(
        selectedCard: .constant(nil),
        selectedCategory: .constant(.closed)
    )
    .modelContainer(PreviewData.shared.modelContainer)
}
