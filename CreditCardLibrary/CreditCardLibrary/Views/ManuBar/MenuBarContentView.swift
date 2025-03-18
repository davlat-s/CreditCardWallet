import SwiftUI
import SwiftData
import AppKit

struct MenuBarContentView: View {
    @Environment(\.openWindow) private var openWindow
    
    @Query(sort: [SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    @Query(sort: [SortDescriptor(\PaymentProcessor.name, order: .forward)]) var paymentProcessors: [PaymentProcessor]
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            Button(action: {
                openWindow(id: "AddCreditCardWindow")
            }) {
                Label("New Credit Card", systemImage: "plus")
                    .labelStyle(.titleAndIcon)
            }
            Section {
                Button("Quit Wallet App") {
                    NSApplication.shared.terminate(nil)
                }
            }
        }
        .padding()
    }
}
