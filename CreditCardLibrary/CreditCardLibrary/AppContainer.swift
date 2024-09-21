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
            PaymentProcessor(name: "Visa", logo: "visaLogo"),
            PaymentProcessor(name: "Mastercard", logo: "mastercardLogo"),
            PaymentProcessor(name: "AmEx", logo: "amexLogo"),
            PaymentProcessor(name: "Discover", logo: "discoverLogo")
        ]
        
        let Banks = [
            Bank(name: "Chase"),
            Bank(name: "American Express"),
            Bank(name: "Bank of America"),
            Bank(name: "Citi"),
            Bank(name: "Wells Fargo"),
            Bank(name: "U.S. Bank"),
        ]
        
        for pp in PaymentProcessors {
            container.mainContext.insert(pp)
        }
        
        var BankFetchDescriptor = FetchDescriptor<Bank>()
        BankFetchDescriptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(BankFetchDescriptor).count == 0 else { return container }
        
        for bank in Banks {
            container.mainContext.insert(bank)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
