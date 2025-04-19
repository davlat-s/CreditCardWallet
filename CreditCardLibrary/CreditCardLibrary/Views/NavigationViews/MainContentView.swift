import SwiftUI
import SwiftData

struct MainContentView: View {
    @Binding var selectedCategory: SideBarCategories
    @Binding var columnVisibility: NavigationSplitViewVisibility
    
    @State private var sortOrder = [SortDescriptor(\CreditCard.openDate, order: .reverse)]
    @State private var searchText: String = ""
    @State private var selectedCard: CreditCard?
    @State private var newCard: Bool = false
    @State private var isEditing: Bool = false
    @State private var toggleHelper = true
    @State private var navigationPath = NavigationPath()
    @State private var cardToDelete: CreditCard? {
        didSet {
            if let card = cardToDelete {
                Log.action.info("Delete alert presented for card: \(card.name)")
            }
        }
    }
    
    @Query(sort: [SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    @Query(sort: [SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
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
        } detail: {
            NavigationStack(path: $navigationPath) {
                Group {
                    if selectedCategory == SideBarCategories.charts {
                        ChartsContentView()
                    } else {
                        GridContentView(searchString: searchText,
                                        sortOrder: sortOrder,
                                        selectedCard: $selectedCard,
                                        selectedCategory: $selectedCategory,
                                        onDoubleTap: { card in
                            withAnimation(.spring()) {
                                navigationPath.append(card)
                            }
                        })
                    }
                }
                .searchable(text: $searchText, placement: .toolbar, prompt: "search")
                .navigationDestination(for: CreditCard.self) { card in
                    ZStack {
                        Color(NSColor.windowBackgroundColor)
                        DetailContentView(creditCard: card)
                            .onAppear {
                                Log.action.info("Detail view appeared for card: \(card.name)")
                            }
                            .background(Color(.background))
                            .navigationBarBackButtonHidden(true)
                            .toolbar {
                                ToolbarItem(placement: .navigation) {
                                    Button {
                                        Log.action.info("User backed out of Detail View for card: \(card.name)")
                                        withAnimation(.spring()) {
                                            navigationPath.removeLast()
                                        }
                                    } label: {
                                        Label("Back", systemImage: "chevron.left")
                                            .imageScale(.large)
                                    }
                                }
                            }
                    }
                }
            }
            .background(Color(.background))
            .navigationSplitViewColumnWidth(min: 350, ideal: 400)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
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
                .disabled(!navigationPath.isEmpty)
                
                Button(action: addCard) {
                    Label("Add Card", systemImage: "plus")
                        .imageScale(.large)
                }
                .disabled(!navigationPath.isEmpty)
                
                Button(action: toggleEditing) {
                    Label("Edit", systemImage: "square.and.pencil")
                        .imageScale(.large)
                }
                .disabled(selectedCard == nil)
                
                Button(action: {
                    Log.action.info("User clicked trash icon")
                    if let selected = selectedCard {
                        cardToDelete = selected
                    }
                }) {
                    Label("Delete", systemImage: "trash")
                        .imageScale(.large)
                }
                .disabled(selectedCard == nil)
            }
        }
        .alert(item: $cardToDelete) { card in
            Alert(
                title: Text("Delete Card"),
                message: Text("Are you sure you want to delete \(card.name)?"),
                primaryButton: .destructive(Text("Delete")) {
                    Log.action.info("User clicked delete")
                    deleteCard(card)
                },
                secondaryButton: .cancel(Text("Cancel"), action: {
                    Log.action.info("User cancelled deletion")
                })
            )
        }
        .sheet(isPresented: $isEditing) {
            if let selectedCard = selectedCard {
                FormEditView(
                    creditCard: selectedCard
                )
                .frame(width: 700, height: 500, alignment: .center)
            }
        }
        .sheet(isPresented: $newCard) {
            FormAddView()
                .frame(width: 700, height: 500, alignment: .center)
        }
    }
    
    private func toggleSidebar() {
        withAnimation {
            toggleHelper.toggle()
            columnVisibility = toggleHelper ? .all : .detailOnly
        }
    }
    
    private func addCard() {
        Log.action.info("User clicked plus icon")
        withAnimation {
            newCard.toggle()
        }
    }
    
    private func toggleEditing() {
        isEditing.toggle()
        if let card = selectedCard {
                Log.action.info("User clicked Edit \(card.name)")
            }
    }
    
    private func deleteCard(_ card: CreditCard) {
        withAnimation {
            modelContext.delete(card)
            Log.action.info("Deleted \(card.name)")
            selectedCard = nil
            selectedCard = nil
            navigationPath = NavigationPath()
        }
    }
}
