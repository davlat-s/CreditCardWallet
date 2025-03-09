import Foundation
import SwiftData
import SwiftUI


@Model
final class CreditCard {
    var name: String
    var creditLimit: String
    var isBusiness: Bool
    var isChargeCard: Bool
    var annualFee: Double?
    var openDate: Date
    var lastDigits: String
    var colorHex: String?
    var history: [String]
    var bank: Bank?
    var promotions: [Promotion]
    var bonuses: [Bonus]
    var closed: Closed?
    var paymentProcessor: PaymentProcessor?
    var cardArt: CardArt?
    
    init(name: String,
         creditLimit: String,
         openDate: Date,
         isBusiness: Bool,
         isChargeCard: Bool,
         annualFee: Double? = 0,
         lastDigits: String,
         colorHex: String? = nil,
         history: [String] = [],
         bank: Bank? = nil,
         promotions: [Promotion] = [],
         bonuses: [Bonus] = [],
         closed: Closed? = nil,
         paymentProcessor: PaymentProcessor? = nil,
         cardArt: CardArt? = nil) {
        self.name = name
        self.creditLimit = creditLimit
        self.openDate = openDate
        self.isBusiness = isBusiness
        self.annualFee = annualFee
        self.lastDigits = lastDigits
        self.bank = bank
        self.promotions = promotions
        self.bonuses = bonuses
        self.closed = closed
        self.paymentProcessor = paymentProcessor
        self.colorHex = colorHex
        self.history = history
        self.isChargeCard = isChargeCard
        self.cardArt = cardArt
    }
    
    static func returnNewCreditCard() -> CreditCard {
        return CreditCard(name: "", creditLimit: "", openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "", history: ["\(Date.now) Credit Card Added", "sdfsdfs", "sdfsdf", "dfsdff"], cardArt: CardArt(assetID: "default"))
    }
    
    static func getHeight(width: Double) -> Double {
        return (width / 8.56) * 5.389
    }
    
    static func getWidth(height: Double) -> Double {
        return height * (8.56 / 5.389)
    }
    
    static let cardWidth: CGFloat = 486
    static let cardHeight: CGFloat = 306
    
    static let sampleData = [
            CreditCard(
                name: "Platinum",
                creditLimit: "110.23",
                openDate: .now,
                isBusiness: false,
                isChargeCard: false,
                lastDigits: "62376",
                history: ["credit limit increased from 3000 to 5000", "card downgraded from x to y"],
                bank: Bank(name: "American Express"),
                promotions: [
                    Promotion(
                        details: "0 APR",
                        startDate: Date.now,
                        endDate: Date.now.addingTimeInterval(60*60*24*30*12)
                    )
                ],
                bonuses: [
                    Bonus(
                        details: "100k sign up bonus",
                        startDate: Date.now,
                        endDate: Date.now.addingTimeInterval(60*60*24*30*3)
                    )
                ],
                closed: Closed(reason: "Too expensive"),
                paymentProcessor: PaymentProcessor.amex,
                cardArt: CardArt.sampleData[0]
            ),
            CreditCard(
                name: "Saphire Reserve",
                creditLimit: "4520.6",
                openDate: .now,
                isBusiness: false,
                isChargeCard: false,
                lastDigits: "3552",
                bank: Bank(name: "Chase"),
                promotions: [
                    Promotion(
                        details: "0 APR",
                        startDate: Date.now,
                        endDate: Date.now.addingTimeInterval(60*60*24*30*12)
                    )
                ],
                bonuses: [
                    Bonus(
                        details: "70k sign up bonus",
                        startDate: Date.now,
                        endDate: Date.now.addingTimeInterval(60*60*24*30*12)
                    )
                ],
                closed: Closed(reason: ""),
                paymentProcessor: PaymentProcessor.visa
            )
        ]
}
