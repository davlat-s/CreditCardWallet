import Foundation
import SwiftData
import SwiftUI


@Model
final class CreditCard {
    var name: String
    var isBusiness: Bool
    var lastDigits: String
    var colorHex: String?
    var bank: Bank?
    var promotion: Promotion?
    var bonus: Bonus?
    var closed: Closed?
    var paymentProcessor: PaymentProcessor?
    var color: Color? {
            get {
                guard let colorHex = colorHex else { return nil }
                return Color(hex: colorHex)
            }
            set {
                colorHex = newValue?.toHex()
            }
        }
    
    init(name: String,
         isBusiness: Bool,
         lastDigits: String,
         colorHex: String? = nil,
         bank: Bank? = nil,
         promotion: Promotion? = nil,
         bonus: Bonus? = nil,
         closed: Closed? = nil,
         paymentProcessor: PaymentProcessor? = nil) {
        self.name = name
        self.isBusiness = isBusiness
        self.lastDigits = lastDigits
        self.bank = bank
        self.promotion = promotion
        self.bonus = bonus
        self.closed = closed
        self.paymentProcessor = paymentProcessor
        self.colorHex = colorHex
    }
    
    static func createNewCard() -> CreditCard {
        return CreditCard(name: "", isBusiness: false, lastDigits: "")
    }
    
    static let sampleData = [
        CreditCard(name: "Platinum", isBusiness: false, lastDigits: "62376", bank: Bank(name: "American Express"), promotion: Promotion(name: "Zero APR for 12 months"), bonus: Bonus(name: "100k sign up bonus"), closed: Closed(reason: "Too expensive", isClosed: true), paymentProcessor: PaymentProcessor.amex),
        CreditCard(name: "Saphire Reserve", isBusiness: false, lastDigits: "3552", bank: Bank(name: "Chase"), promotion: Promotion(name: "Zero APR for 18 months"), bonus: Bonus(name: "80k sign up bonus"), closed: Closed(reason: "", isClosed: false)),
        CreditCard(name: "Ink Preffered", isBusiness: true, lastDigits: "7743"),
        CreditCard(name: "AmEx Gold", isBusiness: false, lastDigits: "6343"),
        CreditCard(name: "Flex", isBusiness: false, lastDigits: "8234"),
        CreditCard(name: "BILT", isBusiness: false, lastDigits: "8322"),
    ]
}
