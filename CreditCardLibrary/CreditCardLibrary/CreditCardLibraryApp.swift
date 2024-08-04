import SwiftUI

@main
struct CreditCardLibraryApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup("Main Widnow") {
            ContentView()
                .environment(modelData)
                .toolbarBackground(.clear)

        }
        .windowStyle(.hiddenTitleBar)
        
    }
}
