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
    var history: [String]
    var bank: Bank?
    var promotion: Promotion?
    var bonus: Bonus?
    var closed: Closed?
    var paymentProcessor: PaymentProcessor?
    var cardArt: CardArt?
    
    init(name: String,
         creditLimit: String,
         openDate: Date,
         isBusiness: Bool,
         isChargeCard: Bool,
         lastDigits: String,
         colorHex: String? = nil,
         history: [String] = [],
         bank: Bank? = nil,
         promotion: Promotion? = nil,
         bonus: Bonus? = nil,
         closed: Closed? = nil,
         paymentProcessor: PaymentProcessor? = nil,
         cardArt: CardArt? = nil) {
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
        self.history = history
        self.isChargeCard = isChargeCard
        self.cardArt = cardArt
    }
    
    static func returnNewCreditCard() -> CreditCard {
        return CreditCard(name: "", creditLimit: "0", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "", history: ["\(Date.now) Credit Card Added", "sdfsdfs", "sdfsdf", "dfsdff"], cardArt: CardArt(assetID: "default"))
    }
    
    
    static let cardWidth: CGFloat = 486
    static let cardHeight: CGFloat = 306
    
    static let sampleData = [
        CreditCard(name: "Platinum",creditLimit: "110.23", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "62376", history: ["credit limit increased from 3000 to 5000", "card downgraded from x to y"], bank: Bank(name: "American Express"), promotion: Promotion(details: "0 APR", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*12)), bonus: Bonus(details: "100k sing up bonus", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*3)), closed: Closed(reason: "Too expensive"), paymentProcessor: PaymentProcessor.amex, cardArt: CardArt.sampleData[0]),
        CreditCard(name: "Saphire Reserve", creditLimit: "4520.6", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "3552", bank: Bank(name: "Chase"), promotion: Promotion(details: "0 APR", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*12)), bonus: Bonus(details: "70k sign up bonus", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*12)), closed: Closed(reason: ""), paymentProcessor: PaymentProcessor.visa),
        CreditCard(name: "Ink Preffered", creditLimit: "520.3",openDate: .now,isBusiness: true, isChargeCard: false, lastDigits: "7743"),
        CreditCard(name: "AmEx Gold", creditLimit: "630.67", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "6343"),
        CreditCard(name: "Flex", creditLimit: "0", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "8234"),
        CreditCard(name: "BILT", creditLimit: "730.3", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "8322"),
    ]
}
