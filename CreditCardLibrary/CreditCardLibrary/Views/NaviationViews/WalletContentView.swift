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
    @State private var toggleHelper = true
    
    @State private var navigationPath = NavigationPath()
    
    @Query(sort:[SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    
    @Query(sort:[SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
        
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView(selectedCategory: $selectedCategory)
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
        }
    detail: {
        NavigationStack(path: $navigationPath){
            CardGridView(searchString: searchText,
                         sortOrder: sortOrder,
                         selectedCard: $selectedCard,
                         selectedCategory: $selectedCategory,
                         onDoubleTap: { card in
                withAnimation(.spring()) {
                    navigationPath.append(card)
                }})
            .searchable(text: $searchText, placement: .toolbar, prompt: "search")
            .navigationDestination(for: CreditCard.self) { card in
                ZStack {
                    Color(NSColor.windowBackgroundColor)
                    DetailPanelView(creditCard: card)
                        .background(Color(.background))
                    

                }
            }
        }
        .background(Color(.background))
        .navigationSplitViewColumnWidth(min: 350, ideal: 400)
        
    }
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
            
            
            Button(action: toggleEditing) {
                Label("Edit", systemImage: "square.and.pencil")
                    .imageScale(.large)
            }.disabled(selectedCard == nil)
            
            Button(action: {
                deleteCard(selectedCard!)
            }) {
                Label("Delete", systemImage: "trash")
                    .imageScale(.large)
            }.disabled(selectedCard == nil)
            
        }
    }
    .sheet(isPresented: $isEditing) {
        if let selectedCard = selectedCard {
            EditCreditCardView(
                creditCard: selectedCard,
                existingBanks: existingBanks,
                paymentProcessors: paymentProcessors)
            .frame(width: 600, height: 500, alignment: .center)
        }
    }
        
    .sheet(item: $newCard) { card in
        AddCreditCardView(
            creditCard: card,
            existingBanks: existingBanks,
            paymentProcessors: paymentProcessors
        )
        .frame(width: 600, height: 500, alignment: .center)
    }
    }
    
    private func toggleSidebar() {
        withAnimation {
            toggleHelper.toggle()
            columnVisibility = toggleHelper ? .all : .detailOnly
        }
    }
    
    private func addCard() {
        withAnimation {
            let newItem = CreditCard.returnNewCreditCard()
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
    WalletContentView(selectedCategory: .constant(.all), columnVisibility: .constant(.all))
        .modelContainer(PreviewData.shared.modelContainer)
}
