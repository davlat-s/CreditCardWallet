import SwiftUI
import SwiftData

struct WalletContentView: View {
    
    @Binding var selectedCategory: SideBarCategories
    @Binding var columnVisibility: NavigationSplitViewVisibility

    @State private var selectedCard: CreditCard?
    @State private var newCard: CreditCard?
    @State private var isEditing: Bool = false
    @Query(sort:[SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    @Query(sort:[SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView(selectedCategory: $selectedCategory)
                .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 400)
        } content: {
            CardListView(selectedCategory: $selectedCategory, selectedCard: $selectedCard)
                .navigationSplitViewColumnWidth(min: 200, ideal: 220, max: 400)
        } detail: {
            if let selectedCard = selectedCard {
                DetailView(creditCard: selectedCard)
            } else {
                Text("Select a credit card")
                    .foregroundStyle(.secondary)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: addCard) {
                    Label("Add Card", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .secondaryAction) {
                if selectedCard != nil {
                    Button(action: toggleEditing) {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                    if let selectedCard = selectedCard {
                        Button(action: {
                            deleteCard(selectedCard) // Wrap in a closure
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
        }
        .sheet(isPresented: $isEditing) {
            if let selectedCard = selectedCard {
                EditCreditCardView(creditCard: selectedCard, existingBanks: existingBanks, paymentProcessors: paymentProcessors)
            }
        }
        .sheet(item: $newCard) { card in
            AddCreditCardView(existingBanks: existingBanks, paymentProcessors: paymentProcessors)
        }
        .interactiveDismissDisabled()
    }
    
    private func addCard() {
        withAnimation {
            let newItem = CreditCard.createNewCard()
            newCard = newItem
        }
    }
    
    private func toggleEditing() {
        isEditing.toggle()
    }
    
    private func deleteCard(_ card: CreditCard) {
            withAnimation {
                modelContext.delete(card)
                selectedCard = nil
            }
        }
    }


// MARK: - Previews

#Preview {
    WalletContentView(selectedCategory: .constant(.open), columnVisibility: .constant(.all))
        .modelContainer(SampleData.shared.modelContainer)
}
