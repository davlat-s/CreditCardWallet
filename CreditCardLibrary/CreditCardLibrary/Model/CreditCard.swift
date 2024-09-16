import Foundation
import SwiftData


@Model
final class CreditCard {
    var name: String
    var isBusiness: Bool
    
    var bank: Bank?
    var promotion: Promotion?
    var bonus: Bonus?
    var closed: Closed?
    
    init(name: String,
         isBusiness: Bool,
         bank: Bank? = nil,
         promotion: Promotion? = nil,
         bonus: Bonus? = nil,
         closed: Closed? = nil) {
        self.name = name
        self.isBusiness = isBusiness
        self.bank = bank
        self.bonus = bonus
        self.closed = closed
        self.promotion = promotion
        
    }
    
    static func createNewCard() -> CreditCard {
            return CreditCard(name: "", isBusiness: false)
    }
    
    static let sampleData = [
        CreditCard(name: "AmEx Platinum", isBusiness: false, bank: Bank(name: "American Express"), promotion: Promotion(name: "Zero APR for 12 months"), bonus: Bonus(name: "100k sign up bonus"), closed: Closed(reason: "Too expensive", isClosed: true)),
        CreditCard(name: "Saphire Reserve", isBusiness: false, bank: Bank(name: "Chase"), promotion: Promotion(name: "Zero APR for 18 months"), bonus: Bonus(name: "80k sign up bonus"), closed: Closed(reason: "", isClosed: false)),
        CreditCard(name: "Ink Preffered", isBusiness: true),
        CreditCard(name: "AmEx Gold", isBusiness: false),
        CreditCard(name: "Flex", isBusiness: false),
        CreditCard(name: "BILT", isBusiness: false),
    ]
}
