

enum PaymentProcessorInstance {
    static let visa = PaymentProcessor(name: "Visa", logo: "visaLogo.png")
    static let mastercard = PaymentProcessor(name: "Mastercard", logo: "mastercardLogo.png")
    static let amex = PaymentProcessor(name: "Amex", logo: "amexLogo.png")
    static let discover = PaymentProcessor(name: "Discover", logo: "discoverLogo.png")

    static var all: [PaymentProcessor] {
        return [visa, mastercard, amex, discover]
    }
}
