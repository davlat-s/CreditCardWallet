import SwiftUI
import SwiftData

struct CardGridView: View {
    
    @Binding var selectedCategory: SideBarCategories
    @Binding var selectedCard: CreditCard?
    
    @Query(sort: \CreditCard.name) private var cards: [CreditCard]
    
    var filteredCreditCards: [CreditCard] {
        cards.filter(selectedCategory.sidebarFilter)
    }
    
    var onDoubleTap: (CreditCard) -> Void
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 230), spacing: 75)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(filteredCreditCards, id: \.id) { card in
                    CardGridCellView(creditCard: card)
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
                                        selectedCard = card
                                    }
                                }
                        )
                }
            }
            .padding()
        }
    }
}

#Preview {
    CardGridView(selectedCategory: .constant(.all), selectedCard: .constant(nil), onDoubleTap: {card in print(card.name)})
        .frame(width: 400)
}
