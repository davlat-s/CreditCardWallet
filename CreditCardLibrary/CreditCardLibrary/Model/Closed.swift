import Foundation
import SwiftData


@Model
final class Closed {
    @Attribute(.unique) var id: UUID

    var reason: String
    var closedDate: Date?
    var creditCard: CreditCard?

    init(id: UUID = UUID(),
         reason: String,
         closedDate: Date? = nil,
         creditCard: CreditCard? = nil) {
        self.id = id

        self.reason = reason
        self.closedDate = closedDate
        self.creditCard = creditCard
    }
    
    static func returnNewClosed() -> Closed {
        return Closed(reason: "")
    }
    
    static let sampleData = [
        Closed(reason: "Closed due to high annual fee", closedDate: Date.now),
        Closed(reason: "Closed due to inactivity", closedDate: Date.now),
    ]
}
