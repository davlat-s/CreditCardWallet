import Foundation
import SwiftData

@Model
final class PaymentProcessor {
    @Attribute(.unique) var id: UUID

    static let visa = PaymentProcessor(name: "Visa", logo: "visaLogo")
    static let mastercard = PaymentProcessor(name: "MasterCard", logo: "mastercardLogo")
    static let amex = PaymentProcessor(name: "Amex", logo: "amexLogo")
    static let discover = PaymentProcessor(name: "Discover", logo: "discoverLogo")

    var name: String
    var logo: String
    var creditCards: [CreditCard] = []
    
    init(id: UUID = UUID(),
         name: String,
         logo: String) {
        self.id = id
        self.name = name
        self.logo = logo
    }
    
    static func returnNewPaymentProcessor() -> PaymentProcessor {
        return PaymentProcessor(name: "", logo: "")
    }
    
    static let sampleData: [PaymentProcessor] = [
        PaymentProcessor(name: "Visa", logo: "visa_logo"),
        PaymentProcessor(name: "Mastercard", logo: "mastercard_logo"),
        PaymentProcessor(name: "American Express", logo: "amex_logo"),
        PaymentProcessor(name: "Discover", logo: "discover_logo")
    ]
}
