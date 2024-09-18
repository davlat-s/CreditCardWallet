import Foundation
import SwiftData

@Model
final class PaymentProcessor {
    var name: String
    var logo: String
    var creditCards: [CreditCard] = []
    
    init(name: String, logo: String) {
        self.name = name
        self.logo = logo
    }
    
    // Static dataset
    static let sampleData: [PaymentProcessor] = [
        PaymentProcessor(name: "Visa", logo: "visa_logo"),
        PaymentProcessor(name: "Mastercard", logo: "mastercard_logo"),
        PaymentProcessor(name: "American Express", logo: "amex_logo"),
        PaymentProcessor(name: "Discover", logo: "discover_logo")
    ]
}
