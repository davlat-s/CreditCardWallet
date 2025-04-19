import os

enum Log {
    static let general = Logger(subsystem: "com.Davlat.CreditCardLibrary", category: "general")
    static let action = Logger(subsystem: "com.Davlat.CreditCardLibrary", category: "action")
    static let error = Logger(subsystem: "com.Davlat.CreditCardLibrary", category: "error")
}
