import Foundation
import SwiftUI

struct CreditCardModel: Hashable, Codable, Identifiable {
    var id: Int
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
    var history: History
    
    private var imageName: String
    struct History: Hashable, Codable {
        var closedDate: Date?
        var downgradeDate: Date?
        var oldCardName: String?
        var bonusAmount: Int?
        var APREndDate: Date?
        var bonusPromotionEndDate: Date?
    }
    
    // calculate age in years
    var age: Double {
        let calendar = Calendar.current
        let now: Date = Date()
        let endDate: Date = history.closedDate ?? now
    
        let components = calendar.dateComponents([.year, .month, .day], from: openDate, to: endDate)
        let years = Double(components.year ?? 0)
        let months = Double(components.month ?? 0) / 12
        let days = Double(components.day ?? 0) / 365
        
        return years + months + days
    }
    
    // format date to english
    func formattedDate(date: Date, format: String = "MMM d, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
