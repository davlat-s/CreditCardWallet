import Foundation
import SwiftData


@Model
final class Promotion {
    var name: String
    var creditCard: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Promotion(name: "0% APR for 12 moths"),
        Promotion(name: "0% APR for 18 moths"),
    ]
}
