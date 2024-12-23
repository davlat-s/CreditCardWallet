import Foundation
import SwiftData
import SwiftUI


@Model
final class CreditCard {
    var name: String
    var creditLimit: String
    var isBusiness: Bool
    var isChargeCard: Bool
    var openDate: Date
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
         creditLimit: String,
         openDate: Date,
         isBusiness: Bool,
         isChargeCard: Bool,
         lastDigits: String,
         colorHex: String? = nil,
         bank: Bank? = nil,
         promotion: Promotion? = nil,
         bonus: Bonus? = nil,
         closed: Closed? = nil,
         paymentProcessor: PaymentProcessor? = nil) {
        self.name = name
        self.creditLimit = creditLimit
        self.openDate = openDate
        self.isBusiness = isBusiness
        self.lastDigits = lastDigits
        self.bank = bank
        self.promotion = promotion
        self.bonus = bonus
        self.closed = closed
        self.paymentProcessor = paymentProcessor
        self.colorHex = colorHex
        self.isChargeCard = isChargeCard
    }
    
    static func createNewCard() -> CreditCard {
        return CreditCard(name: "", creditLimit: "0", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "")
    }
    
    static let cardWidth: CGFloat = 486
    static let cardHeight: CGFloat = 306
    
    static let sampleData = [
        CreditCard(name: "Platinum", creditLimit: "110.23", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "62376", bank: Bank(name: "American Express"), promotion: Promotion(name: "Zero APR for 12 months"), bonus: Bonus(name: "100k sign up bonus"), closed: Closed(reason: "Too expensive"), paymentProcessor: PaymentProcessor.amex),
        CreditCard(name: "Saphire Reserve", creditLimit: "4520.6", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "3552", bank: Bank(name: "Chase"), promotion: Promotion(name: "Zero APR for 18 months"), bonus: Bonus(name: "80k sign up bonus"), closed: Closed(reason: ""), paymentProcessor: PaymentProcessor.visa),
        CreditCard(name: "Ink Preffered", creditLimit: "520.3",openDate: .now,isBusiness: true, isChargeCard: false, lastDigits: "7743"),
        CreditCard(name: "AmEx Gold", creditLimit: "630.67", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "6343"),
        CreditCard(name: "Flex", creditLimit: "0", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "8234"),
        CreditCard(name: "BILT", creditLimit: "730.3", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "8322"),
    ]
}
