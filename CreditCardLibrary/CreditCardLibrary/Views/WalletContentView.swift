import SwiftUI

struct WalletContentView: View {
    
    @State var selectedCategory: Category
    @State private var selectedCard: CreditCard?
    @State var columnVisibility: NavigationSplitViewVisibility
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            Section("Categories") {
                List(Category.allCases, selection: $selectedCategory) {
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
                CreditCardDetail(card: selectedCard)
            } else {
                Text("Select a card")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    WalletContentView(selectedCategory: .open, columnVisibility: .doubleColumn)
        .modelContainer(SampleData.shared.modelContainer)
}
