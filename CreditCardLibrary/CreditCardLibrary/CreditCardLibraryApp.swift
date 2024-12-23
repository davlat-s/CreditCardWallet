import SwiftUI
import SwiftData

@main
@MainActor
struct CreditCardLibraryApp: App {
    var body: some Scene {
        WindowGroup("Main Widnow") {
            WalletContentView(selectedCategory: $sidebarSelection, columnVisibility: $columnVisibility)
                .toolbarBackground(.ultraThickMaterial)
        }
        .defaultPosition(.center)
        .modelContainer(appContainer)
        .windowStyle(.hiddenTitleBar)
        
    }
    @State var sidebarSelection: SideBarCategories = .all
    @State var columnVisibility: NavigationSplitViewVisibility = .all
}

