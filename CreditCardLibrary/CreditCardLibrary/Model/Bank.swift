import Foundation
import SwiftData

@Model
class Bank {
    @Attribute(.unique) var id: String
    @Attribute(.unique) var name: String
    var creditCards: [CreditCard]
    
    init(id: String, name: String, creditCards: [CreditCard]) {
        self.id = id
        self.name = name
        self.creditCards = creditCards
    }
}
