import Foundation
import SwiftData


@Model
final class Bonus {
    @Attribute(.unique) var id: UUID
    
    var details: String
    var startDate: Date?
    var endDate: Date?
    var creditCard: CreditCard?
    
    init(id: UUID = UUID(),
         details: String,
         startDate: Date? = nil,
         endDate: Date? = nil,
         creditCard: CreditCard? = nil) {
        self.id = id

        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.creditCard = creditCard
    }
    
    static func returnNewBonus() -> Bonus {
        return Bonus(details: "")
    }
    
    static let sampleData = [
        Bonus(details: "80k sign up bonus after $6,000 spend in 3 months", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*3)),
        Bonus(details: "180k sign up bonus after $12,000 spend in 3 months", startDate: Date.now, endDate: Date.now.addingTimeInterval(60*60*24*30*3)),
    ]
}
