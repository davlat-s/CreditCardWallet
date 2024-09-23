import Foundation
import SwiftData

@MainActor
class PreviewData {
    
    static let shared = PreviewData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            CreditCard.self,
            Bank.self,
            Promotion.self,
            Bonus.self,
            Closed.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            self.insertSampleData()
            
        } catch {
            fatalError("Could not create ModelContainer for SampleData: \(error)")
        }
    }
    
    // inserts sample data from each model into SampleData context
    func insertSampleData() {
        for card in CreditCard.sampleData {
            context.insert(card)
        }
        
        for promo in Promotion.sampleData {
            context.insert(promo)
        }
        
        for bank in Bank.sampleData {
            context.insert(bank)
        }
        
        for bonus in Bonus.sampleData {
            context.insert(bonus)
        }
        
        for closed in Closed.sampleData {
            context.insert(closed)
        }
        
        for pp in PaymentProcessor.sampleData {
            context.insert(pp)
        }
        
        if let sampleCreditCard = CreditCard.sampleData.first {
            sampleCreditCard.bank = Bank.sampleData[1]
            sampleCreditCard.closed = Closed.sampleData[0]
            sampleCreditCard.bonus = Bonus.sampleData[0]
            sampleCreditCard.closed = Closed.sampleData[0]
        }
        
        do {
            try context.save()
        } catch {
            print("Sample data context failed to save")
        }
    }
    
    
    // returns a sample of each Model
    var creditCard : CreditCard {
        CreditCard.sampleData[0]
    }
    
    var bank: Bank {
        Bank.sampleData[0]
    }
    
    var promotion: Promotion {
        Promotion.sampleData[0]
    }
    
    var bonus: Bonus {
        Bonus.sampleData[0]
    }
    
    var closed: Closed {
        Closed.sampleData[0]
    }
    
    var paymentProcessor: PaymentProcessor {
        PaymentProcessor.sampleData[0]
    }
    
    var openCategory = SideBarCategories.open
    var businessCategory = SideBarCategories.business
    var personalCategory = SideBarCategories.personal
    var closedCategory = SideBarCategories.closed
    
}
