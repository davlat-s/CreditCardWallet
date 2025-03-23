import Foundation
import SwiftData

// TODO: Decouple the injected data from the MainAppContainer

@MainActor
let MainAppContainer
: ModelContainer = {
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
        
        
        func bank(withName name: String, in context: ModelContext) -> Bank? {
            let request = FetchDescriptor<Bank>(predicate: #Predicate { bank in
                bank.name == name
            })
            return try? context.fetch(request).first
        }
        
        if let chaseBank = bank(withName: "Chase", in: container.mainContext) {
            let newCards = [
                CreditCard(
                    name: "Sapphire Reserve",
                    creditLimit: 12000,
                    openDate: Calendar.current.date(byAdding: .year, value: -2, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 450,
                    lastDigits: "3552",
                    bank: chaseBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Chase-Personal_Credi_Cards-Sapphire_Reserve")
                ),
                CreditCard(
                    name: "Ink Unlimited",
                    creditLimit: 24000,
                    openDate: Calendar.current.date(byAdding: .year, value: -1, to: Date.now) ?? Date.now,
                    isBusiness: true,
                    isChargeCard: false,
                    annualFee: 95,
                    lastDigits: "3532",
                    bank: chaseBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Chase-Business_Cards-Ink_Unlimited")
                ),
                CreditCard(
                    name: "Freedom Flex",
                    creditLimit: 6000,
                    openDate: Calendar.current.date(byAdding: .year, value: -4, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 0,
                    lastDigits: "3556",
                    bank: chaseBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Chase-Personal_Credi_Cards-Freedom_Flex")
                ),
                CreditCard(
                    name: "Freedom Unlimited",
                    creditLimit: 2000,
                    openDate: Calendar.current.date(byAdding: .year, value: -6, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 0,
                    lastDigits: "3656",
                    bank: chaseBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: Closed(reason: "just because"),
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Chase-Personal_Credi_Cards-Freedom_Unlimited")
                ),
                CreditCard(
                    name: "Ink Premier",
                    creditLimit: 28000,
                    openDate: Calendar.current.date(byAdding: .year, value: -3, to: Date.now) ?? Date.now,
                    isBusiness: true,
                    isChargeCard: false,
                    annualFee: 195,
                    lastDigits: "9356",
                    bank: chaseBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Chase-Business_Cards-jpeg-ink_premier")
                ),]
            for card in newCards {
                container.mainContext.insert(card)
            }
        }
        
        if let amExBank = bank(withName: "American Express", in: container.mainContext) {
            let newCards = [
                CreditCard(
                    name: "Centurion",
                    creditLimit: nil,
                    openDate: Calendar.current.date(byAdding: .year, value: -1, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: true,
                    annualFee: 950,
                    lastDigits: "35552",
                    bank: amExBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.amex,
                    cardArt: CardArt(assetID: "American_Express-Personal-jpeg-Centurion_2")
                ),
                CreditCard(
                    name: "Platinum",
                    creditLimit: nil,
                    openDate: Calendar.current.date(byAdding: .year, value: -3, to: Date.now) ?? Date.now,
                    isBusiness: true,
                    isChargeCard: true,
                    annualFee: 695,
                    lastDigits: "35332",
                    bank: amExBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.amex,
                    cardArt: CardArt(assetID: "American_Express-Business-jpeg-Bunisess_Platinum_2024")
                ),
                CreditCard(
                    name: "Gold",
                    creditLimit: nil,
                    openDate: Calendar.current.date(byAdding: .year, value: -5, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 295,
                    lastDigits: "35356",
                    bank: amExBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.amex,
                    cardArt: CardArt(assetID: "American_Express-Personal-White_Gold")
                ),
                CreditCard(
                    name: "Hilton Aspire",
                    creditLimit: 4000,
                    openDate: Calendar.current.date(byAdding: .year, value: -3, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 450,
                    lastDigits: "3652",
                    bank: amExBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.amex,
                    cardArt: CardArt(assetID: "American_Express-Personal-Hilton_Honors_Aspire_old")
                ),
                CreditCard(
                    name: "Every Day Preferred",
                    creditLimit: 28000,
                    openDate: Calendar.current.date(byAdding: .year, value: -4, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 95,
                    lastDigits: "33556",
                    bank: amExBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.amex,
                    cardArt: CardArt(assetID: "American_Express-Personal-low_res-Every_Day_Preferred")
                ),]
            for card in newCards {
                container.mainContext.insert(card)
            }
        }
        
        if let citiBank = bank(withName: "Citi", in: container.mainContext) {
            let newCards = [
                CreditCard(
                    name: "Rewards",
                    creditLimit: 10000,
                    openDate: Calendar.current.date(byAdding: .year, value: -2, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 450,
                    lastDigits: "5552",
                    bank: citiBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Citi-Rewards")
                ),
                CreditCard(
                    name: "Double Cash",
                    creditLimit: 3000,
                    openDate: Calendar.current.date(byAdding: .year, value: -3, to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 0,
                    lastDigits: "3752",
                    bank: citiBank,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Citi-low_res-Double_Cash_2024")
                )]
            for card in newCards {
                container.mainContext.insert(card)
            }
        }
        
        if let wellsFargo = bank(withName: "Wells Fargo", in: container.mainContext) {
            let newCards = [
                CreditCard(
                    name: "BILT",
                    creditLimit: 16000,
                    openDate: Calendar.current.date(byAdding: .year, value: Int(-1.5), to: Date.now) ?? Date.now,
                    isBusiness: false,
                    isChargeCard: false,
                    annualFee: 0,
                    lastDigits: "5852",
                    bank: wellsFargo,
                    promotions: [/*...*/],
                    bonuses: [/*...*/],
                    closed: nil,
                    paymentProcessor: PaymentProcessor.visa,
                    cardArt: CardArt(assetID: "Others-Credit_Cards-jpeg-Bilt")
                )]
            for card in newCards {
                container.mainContext.insert(card)
            }
        }
        
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
