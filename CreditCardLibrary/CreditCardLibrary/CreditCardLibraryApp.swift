import SwiftUI

@main
struct CreditCardLibraryApp: App {
    var body: some Scene {
        WindowGroup("Main Widnow") {
            ContentView()
                .toolbarBackground(.ultraThickMaterial)
        }
        .modelContainer(for: [CreditCard.self])
        .windowStyle(.hiddenTitleBar)
        
    }
}
