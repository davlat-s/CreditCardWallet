import SwiftUI

@main
struct CreditCardLibraryApp: App {
    var body: some Scene {
        WindowGroup("Main Widnow") {
            ContentView()
                .toolbarBackground(.ultraThinMaterial)

        }
        .modelContainer(for: [CreditCard.self])
//        .windowStyle(.hiddenTitleBar)
        
    }
}
