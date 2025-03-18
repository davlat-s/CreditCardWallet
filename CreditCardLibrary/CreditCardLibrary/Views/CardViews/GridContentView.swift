import SwiftUI
import SwiftData

struct GridContentView: View {
    
    @Binding var selectedCategory: SideBarCategories
    @Binding var selectedCard: CreditCard?
    
    @Query(sort: \CreditCard.name) private var cards: [CreditCard]
    
    var filteredCreditCards: [CreditCard] {
        cards.filter(selectedCategory.sidebarFilter)
    }
    
    var onDoubleTap: (CreditCard) -> Void
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 275, maximum: 350), spacing: 0)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(filteredCreditCards, id: \.id) { card in
                    CardCellView(creditCard: card)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(selectedCard == card ? Color.accentColor.opacity(0.8) : Color.clear, lineWidth: 3)
                        )
                        .simultaneousGesture(
                            TapGesture(count: 2)
                                .onEnded {
                                    onDoubleTap(card)
                                }
                        )
                        .simultaneousGesture(
                            TapGesture(count: 1)
                                .onEnded {
                                    DispatchQueue.main.async {
                                        selectedCard = card}
                                }
                        )
                }
            }
            .padding()
        }
    }
    init(searchString: String = "", 
         sortOrder: [SortDescriptor<CreditCard>] = [],
         selectedCard: Binding<CreditCard?>,
         selectedCategory: Binding<SideBarCategories>,
         onDoubleTap: @escaping (CreditCard) -> Void
    ) {
        _selectedCard = selectedCard
        _selectedCategory = selectedCategory
        self.onDoubleTap = onDoubleTap
        _cards = Query(filter: #Predicate { card in
            if searchString.isEmpty {
                return true
            } else {
                return card.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
}

