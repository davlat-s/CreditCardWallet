import SwiftUI
import SwiftData

struct WalletContentView: View {
    
    @Binding var selectedCategory: SideBarCategories
    @Binding var columnVisibility: NavigationSplitViewVisibility
    
    @State private var sortOrder = [SortDescriptor(\CreditCard.openDate, order: .reverse)]
    @State private var searchText: String = ""
    @State private var selectedCard: CreditCard?
    @State private var newCard: CreditCard?
    @State private var isEditing: Bool = false
    @Query(sort:[SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    
    @Query(sort:[SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var banksWithCreditCards: [Bank] = []
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView(selectedCategory: $selectedCategory, banksWCards: $banksWithCreditCards)
                .toolbar(removing: .sidebarToggle)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            toggleSidebar()
                        }) {
                            Label("Toggle Sidebar", systemImage: "sidebar.leading")
                                .imageScale(.large)
                        }
                    }
                }
                .navigationSplitViewColumnWidth(min: 150, ideal: 150, max: 250)
            
            
            
        } content: {
            NavigationStack {
                CardListView(searchString: searchText, sortOrder: sortOrder, selectedCard: $selectedCard, selectedCategory: $selectedCategory)
                    .toolbar {
                        ToolbarItemGroup(placement: .primaryAction) {
                            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                                Picker("Open Date", selection: $sortOrder) {
                                    Text("Newest").tag([SortDescriptor(\CreditCard.openDate, order: .reverse)])
                                    Text("Oldest").tag([SortDescriptor(\CreditCard.openDate)])
                                }
                                .imageScale(.large)
                                
                                Picker("Credit Limit", selection: $sortOrder) {
                                    Text("Highest").tag([SortDescriptor(\CreditCard.creditLimit, order: .reverse)])
                                    Text("Lowest").tag([SortDescriptor(\CreditCard.creditLimit)])
                                }
                                .imageScale(.large)
                                
                                Picker("Name", selection: $sortOrder) {
                                    Text("A-Z").tag([SortDescriptor(\CreditCard.name)])
                                    Text("Z-A").tag([SortDescriptor(\CreditCard.name, order: .reverse)])
                                }
                                .imageScale(.large)
                                
                            }
                            
                            Button(action: addCard) {
                                Label("Add Card", systemImage: "plus")
                                    .imageScale(.large)
                                
                            }
                            
                            if selectedCard != nil {
                                Button(action: toggleEditing) {
                                    Label("Edit", systemImage: "square.and.pencil")
                                        .imageScale(.large)
                                    
                                }
                                
                                Button(action: {
                                    deleteCard(selectedCard!)
                                }) {
                                    Label("Delete", systemImage: "trash")
                                        .imageScale(.large)
                                }
                            }
                        }
                    }
                
            }
            
            .searchable(text: $searchText)
            .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 350)
        } detail: {
            if let selectedCard = selectedCard {
                DetailPanelView(creditCard: selectedCard)
            } else {
                NavigationStack {
                    SelectCardView()
                }
                .navigationSplitViewColumnWidth(min: 250, ideal: 400)
            }
        }
        .onChange(of: existingBanks) {
            filterBanksWithCreditCards()
        }
        
        
        .sheet(isPresented: $isEditing) {
            if let selectedCard = selectedCard {
                EditCreditCardView(
                    creditCard: selectedCard,
                    existingBanks: existingBanks,
                    paymentProcessors: paymentProcessors,
                    filterCallback: filterBanksWithCreditCards)
                .frame(width: 600, height: 500, alignment: .center)
            }
        }
        
        .sheet(item: $newCard) { card in
            AddCreditCardView(
                creditCard: card,
                existingBanks: existingBanks,
                paymentProcessors: paymentProcessors,
                filterCallback: filterBanksWithCreditCards
            )
            .frame(width: 600, height: 500, alignment: .center)
        }
    }
    
    private func toggleSidebar() {
        withAnimation{
            columnVisibility = columnVisibility == .automatic ? .all : .automatic
        }
    }
    
    func filterBanksWithCreditCards() {
        banksWithCreditCards = existingBanks.filter { !$0.creditCards.isEmpty }
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
            filterBanksWithCreditCards()
        }
    }
}


// MARK: - Previews

#Preview {
    WalletContentView(selectedCategory: .constant(.all), columnVisibility: .constant(.all))
        .modelContainer(PreviewData.shared.modelContainer)
}
