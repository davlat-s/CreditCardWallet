import SwiftUI
import SwiftData

@main
@MainActor
struct CreditCardLibraryApp: App {
    
    @AppStorage(AppStorageKeys.menuBarShown) var menuBarShown: Bool = true
    
    let modelContainer = try! ModelContainer(for: CreditCard.self, Bank.self, PaymentProcessor.self)
    
    var body: some Scene {
        
        WindowGroup("Main Widnow") {
            MainContentView(selectedCategory: $sidebarSelection, columnVisibility: $columnVisibility)
                .toolbarBackground(.ultraThickMaterial)
                .frame(minWidth: 600, idealWidth: 1200, maxWidth: 1400, minHeight: 300, idealHeight: 600, maxHeight: 900)
                .onAppear {
                    columnVisibility = .all
                }
        }
        .defaultPosition(.center)
        .defaultSize(width: 1200, height: 900)
        .modelContainer(MainAppContainer
        )
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        
        Settings {
            SettingsContentView()
        }
        .modelContainer(MainAppContainer
        )
        
        MenuBarExtra(isInserted: $menuBarShown) {
            MenuBarContentView()
        } label: {
            Label("WalletApp", systemImage: "creditcard.fill")
        }
        .modelContainer(MainAppContainer
        )
        .menuBarExtraStyle(.menu)
        
        WindowGroup("Add Credit Card", id: "AddCreditCardWindow") {
            FormAddView()
                .frame(width: 700, height: 800, alignment: .center)
            
        }
        .defaultPosition(.top )
        .modelContainer(MainAppContainer
        )
        .windowResizability(.contentSize)
        
    }
    @State var sidebarSelection: SideBarCategories = .all
    @State var columnVisibility: NavigationSplitViewVisibility = .all
}
