import Foundation
import SwiftUI

struct CreditCard: Hashable, Codable, Identifiable {
    var id: Int
    var cardName: String
    var bankName: String
    var openDate: String
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
    var history: History
    
    private var imageName: String
    struct History: Hashable, Codable {
        var closedDate: String?
        var downgradeDate: String?
        var oldCardName: String?
        var bonusAmount: Int?
        var APREndDate: String?
        var bonusPromotionEndDate: String?
        
    }
}
