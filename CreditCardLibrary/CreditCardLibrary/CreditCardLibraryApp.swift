import SwiftUI
import SwiftData

@main
@MainActor
struct CreditCardLibraryApp: App {
    var body: some Scene {
        WindowGroup("Main Widnow") {
            WalletContentView(selectedCategory: $sidebarSelection, columnVisibility: $columnVisibility)
                .toolbarBackground(.ultraThickMaterial)
                .frame(minWidth: 600, idealWidth: 1200, maxWidth: 1400, minHeight: 300, idealHeight: 600, maxHeight: 700)
                .onAppear {
                    columnVisibility = .all
                }
        }
        .defaultPosition(.center)
        .defaultSize(width: 1200, height: 900)
        .modelContainer(appContainer)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        
    }
    @State var sidebarSelection: SideBarCategories = .all
    @State var columnVisibility: NavigationSplitViewVisibility = .all
}

