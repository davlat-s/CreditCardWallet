import Foundation
import SwiftData
import SwiftUI

@Model
class CreditCard {
    var id: String
    var cardName: String
    var bankName: String
    var openDate: Date
    var image: Image {
        Image(imageName)
    }
    
    var annualFee: Int
    var dueDay: Int
    var creditLimit: Double
    var isChargeCard: Bool
    var isBusiness: Bool
    var isClosed: Bool
    var wasDowngraded: Bool
    var hasAPRPromotion: Bool
    var hasBonusPromotion: Bool
    
    private var imageName: String
    
    var closedDate: Date?
    var downgradeDate: Date?
    var oldCardName: String?
    var bonusAmount: Int?
    var APREndDate: Date?
    var bonusPromotionEndDate: Date?
    
    init(id: String, cardName: String, bankName: String, openDate: Date, annualFee: Int, dueDay: Int, creditLimit: Double, isChargeCard: Bool, isBusiness: Bool, isClosed: Bool, wasDowngraded: Bool, hasAPRPromotion: Bool, hasBonusPromotion: Bool, imageName: String, closedDate: Date? = nil, downgradeDate: Date? = nil, oldCardName: String? = nil, bonusAmount: Int? = nil, APREndDate: Date? = nil, bonusPromotionEndDate: Date? = nil) {
        self.id = id
        self.cardName = cardName
        self.bankName = bankName
        self.openDate = openDate
        self.annualFee = annualFee
        self.dueDay = dueDay
        self.creditLimit = creditLimit
        self.isChargeCard = isChargeCard
        self.isBusiness = isBusiness
        self.isClosed = isClosed
        self.wasDowngraded = wasDowngraded
        self.hasAPRPromotion = hasAPRPromotion
        self.hasBonusPromotion = hasBonusPromotion
        self.imageName = imageName
        self.closedDate = closedDate
        self.downgradeDate = downgradeDate
        self.oldCardName = oldCardName
        self.bonusAmount = bonusAmount
        self.APREndDate = APREndDate
        self.bonusPromotionEndDate = bonusPromotionEndDate
    }
}
