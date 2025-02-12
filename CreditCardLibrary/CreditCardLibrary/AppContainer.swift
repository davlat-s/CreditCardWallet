import Foundation
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: CreditCard.self,
            Bank.self, Closed.self,
            Promotion.self, Bonus.self,
            PaymentProcessor.self,
            CardArt.self)
        
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
        
        
        for pp in PaymentProcessors {
            container.mainContext.insert(pp)
        }
        
        var BankFetchDescriptor = FetchDescriptor<Bank>()
        BankFetchDescriptor.fetchLimit = 1

        guard try container.mainContext.fetch(BankFetchDescriptor).count == 0 else {
            // If there’s already a bank, do nothing more
            return container
        }

        // Attempt to load the JSON file
        if let bankCardArtData = loadBankCardArtData() {

            for (bankName, filenames) in bankCardArtData {
                // Create Bank entity
                let bank = Bank(name: bankName)
                container.mainContext.insert(bank)
                
                // Create CardArt for each filename
                for artFilename in filenames {
                    let cardArt = CardArt(assetID: artFilename, bank: bank)
                    container.mainContext.insert(cardArt)
                }
            }
            
            // Save context to persist data
            try? container.mainContext.save()
        } else {
            print("Could not load JSON bank + cardArt data.")
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
