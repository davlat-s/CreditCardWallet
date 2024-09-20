import Foundation
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: CreditCard.self, Bank.self, Closed.self, Promotion.self, Bonus.self, PaymentProcessor.self)
        
        // Make sure the persistent store is empty. If it's not, return the non-empty container.
        var PaymentProcessorFetchDescriptor = FetchDescriptor<PaymentProcessor>()
        PaymentProcessorFetchDescriptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(PaymentProcessorFetchDescriptor).count == 0 else { return container }
        
        // This code will only run if the persistent store is empty.
        let PaymentProcessors = [
            PaymentProcessor(name: "Visa", logo: "visaLogo.png"),
            PaymentProcessor(name: "Mastercard", logo: "mastercardLogo.png"),
            PaymentProcessor(name: "Amex", logo: "amexLogo.png"),
            PaymentProcessor(name: "Discover", logo: "discoverLogo.png")
        ]
        
        for pp in PaymentProcessors {
            container.mainContext.insert(pp)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
