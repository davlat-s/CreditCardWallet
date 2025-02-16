import Foundation
import SwiftData


@Model
final class Promotion {
    var details: String
    var startDate: Date?
    var endDate: Date?
    var creditCard: CreditCard?
    
    init(details: String, startDate: Date? = nil, endDate: Date? = nil, creditCard: CreditCard? = nil) {
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.creditCard = creditCard
    }
    
    static func returnNewPromotion() -> Promotion {
        return Promotion(details: "")
    }
    
    static let sampleData = [
        Promotion(details: "0% APR for 12 moths", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*12)),
        Promotion(details: "0% APR for 18 moths", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*18)),
    ]
}
