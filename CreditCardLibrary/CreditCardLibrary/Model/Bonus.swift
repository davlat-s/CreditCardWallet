import Foundation
import SwiftData


@Model
final class Bonus {
    var name: String
    var creditCard: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Bonus(name: "80k sign up bonus after $6,000 spend in 3 months"),
        Bonus(name: "180k sign up bonus after $12,000 spend in 3 months"),
    ]
}
