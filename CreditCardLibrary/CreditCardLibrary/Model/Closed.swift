import Foundation
import SwiftData


@Model
final class Closed {
    var isClosed: Bool
    var reason: String
    var creditCard: CreditCard?
    
    init(reason: String, isClosed: Bool) {
        self.reason = reason
        self.isClosed = isClosed
    }
    
    static let sampleData = [
        Closed(reason: "Closed due to high annual fee", isClosed: true),
        Closed(reason: "Closed due to inactivity", isClosed: true),
    ]
}
