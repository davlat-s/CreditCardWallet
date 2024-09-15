import SwiftUI
import SwiftData

struct WalletContentView: View {
    
    @State var selectedCategory: SideBarCategories
    @State private var selectedCard: CreditCard?
    @State var columnVisibility: NavigationSplitViewVisibility
    @State private var newCard: CreditCard?
    @State private var isEditing: Bool = false
    @Query var existingBanks: [Bank]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            Section("Categories") {
                List(SideBarCategories.allCases, selection: $selectedCategory) {
                    selection in NavigationLink(value: selection) {
                        Label(selection.displayName, systemImage: selection.displayImageName)
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 400)
        } content: {
            CardListView(selectedCategory: $selectedCategory, selectedCard: $selectedCard)
                .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 400)
        } detail: {
            if let selectedCard = selectedCard {
                CreditCardDetail(creditCard: selectedCard)
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
                if let selectedCard = selectedCard {
                    Button(action: toggleEditing) {
                        Text(isEditing ? "Done Editing" : "Edit")
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
            EditCreditCardView(creditCard: selectedCard, existingBanks: existingBanks)
        }
        .sheet(item: $newCard) { card in
            AddCreditCardView(creditCard: card, existingBanks: existingBanks)
        }
        .interactiveDismissDisabled()
    }
    
    private func addCard() {
        withAnimation {
            let newItem = CreditCard.createNewCard()
            modelContext.insert(newItem)
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
    WalletContentView(selectedCategory: .open, columnVisibility: .doubleColumn)
        .modelContainer(SampleData.shared.modelContainer)
}
