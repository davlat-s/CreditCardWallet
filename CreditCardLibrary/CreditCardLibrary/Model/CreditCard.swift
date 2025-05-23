import Foundation
import SwiftData
import SwiftUI


@Model
final class CreditCard {
    @Attribute(.unique) var id: UUID

    var name: String
    var creditLimit: Double?
    var isBusiness: Bool
    var isChargeCard: Bool
    var annualFee: Double?
    var openDate: Date
    var lastDigits: String
    var history: [HistoryEntry]
    var bank: Bank?
    var promotions: [Promotion]
    var bonuses: [Bonus]
    var closed: Closed?
    var paymentProcessor: PaymentProcessor?
    var cardArt: CardArt?
    
    init(id: UUID = UUID(),
         name: String,
         creditLimit: Double? = nil,
         openDate: Date,
         isBusiness: Bool,
         isChargeCard: Bool,
         annualFee: Double? = 0,
         lastDigits: String,
         history: [HistoryEntry] = [],
         bank: Bank? = nil,
         promotions: [Promotion] = [],
         bonuses: [Bonus] = [],
         closed: Closed? = nil,
         paymentProcessor: PaymentProcessor? = nil,
         cardArt: CardArt? = nil) {
        self.id = id
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
        self.history = history
        self.isChargeCard = isChargeCard
        self.cardArt = cardArt
    }
    
    
    
    static func returnNewCreditCard() -> CreditCard {
        return CreditCard(name: "", creditLimit: nil, openDate: .now, isBusiness: false, isChargeCard: false, lastDigits: "", history: [], cardArt: CardArt(assetID: "default"))
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
            creditLimit: 110,
            openDate: .now,
            isBusiness: false,
            isChargeCard: false,
            lastDigits: "62376",
            history: [],
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
            creditLimit: 3000,
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

extension CreditCard {
    /// Returns a deep copy of the CreditCard instance, while keeping the same instances of associated objects
    func deepCopy() -> CreditCard {
        return CreditCard(
            name: self.name,
            creditLimit: self.creditLimit,
            openDate: self.openDate,
            isBusiness: self.isBusiness,
            isChargeCard: self.isChargeCard,
            annualFee: self.annualFee,
            lastDigits: self.lastDigits
        )
    }
    
    /// Computed properties to return the same instances of associated objects
    var bankInstance: Bank? {
        return self.bank
    }
    
    var promotionsInstance: [Promotion] {
        return self.promotions
    }
    
    var bonusesInstance: [Bonus] {
        return self.bonuses
    }
    
    var closedInstance: Closed? {
        return self.closed
    }
    
    var paymentProcessorInstance: PaymentProcessor? {
        return self.paymentProcessor
    }
    
    var cardArtInstance: CardArt? {
        return self.cardArt
    }
}
