import Foundation
import SwiftData


@Model
final class Closed {
    var reason: String
    var creditCard: CreditCard?
    
    init(reason: String) {
        self.reason = reason
    }
    
    static let sampleData = [
        Closed(reason: "Closed due to high annual fee"),
        Closed(reason: "Closed due to inactivity"),
    ]
}
