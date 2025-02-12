import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Binding var selectedCategory: SideBarCategories
    
    @State private var selectedCard: CreditCard?
    @State private var newCard: CreditCard?
    
    @Query(sort:[SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationSplitView{
            SidebarView(selectedCategory: $selectedCategory)
        }detail: {
            NavigationStack{
                Text("")
//                CardGridView(selectedCategory: $selectedCategory, selectedCard: $selectedCard, onDoubleTap: <#(CreditCard) -> Void#>)
            }
        }
        .toolbar {
            ToolbarItem{
                Button(action: addCard) {
                    Label("Add Card", systemImage: "plus")
                        .imageScale(.large)
                    
                }
            }
        }
    }
    
    private func addCard() {
        withAnimation {
            let newItem = CreditCard.createNewCard()
            modelContext.insert(newItem)
            newCard = newItem
        }
    }
}


#Preview {
    ContentView(selectedCategory: .constant(.all))
}
