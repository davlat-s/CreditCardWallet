import SwiftUI
import SwiftData

@main
struct CreditCardLibraryApp: App {
    var body: some Scene {
        WindowGroup("Main Widnow") {
            WalletContentView(selectedCategory: sidebarSelection, columnVisibility: columnVisibility)
                .toolbarBackground(.ultraThickMaterial)
        }
        .modelContainer(for: [CreditCard.self, Bank.self, Closed.self, Promotion.self, Bonus.self])
        .windowStyle(.hiddenTitleBar)
        
    }
    @State var sidebarSelection: Category = .open
    @State var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
}
