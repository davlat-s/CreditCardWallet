import Foundation
import SwiftData


@Model
final class Bank {
    var name: String
    var creditCards: [CreditCard] = []
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [Bank
//        Bank(name: "Chace"),
//        Bank(name: "American Express"),
    ]()
}
