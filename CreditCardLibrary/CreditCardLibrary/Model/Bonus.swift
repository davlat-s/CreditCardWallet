import Foundation
import SwiftData

@Model
class Bonus {
    @Attribute(.unique) var id: String
    var startDate: Date
    var endDate: Date
    var spendRequired: Int
    var rewardPoints: Int
    var creditCard: CreditCard
    
    init(id: String, startDate: Date, endDate: Date, spendRequired: Int, rewardPoints: Int, creditCard: CreditCard) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.spendRequired = spendRequired
        self.rewardPoints = rewardPoints
        self.creditCard = creditCard
    }
}
