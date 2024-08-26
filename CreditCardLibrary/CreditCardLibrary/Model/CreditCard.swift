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
    
    init(name: String, isBusiness: Bool) {
        self.name = name
        self.isBusiness = isBusiness
    }
    
    static let sampleData = [
        CreditCard(name: "AmEx Platinum", isBusiness: false),
        CreditCard(name: "Sapphire Reserve", isBusiness: false),
        CreditCard(name: "Ink Preffered", isBusiness: true),
        CreditCard(name: "AmEx Gold", isBusiness: false),
        CreditCard(name: "Flex", isBusiness: false),
        CreditCard(name: "BILT", isBusiness: false),
    ]
}
