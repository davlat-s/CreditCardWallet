import Foundation
import SwiftData


@Model
final class Bank {
    @Attribute(.unique) var name: String        
    @Relationship var creditCards: [CreditCard] = []
    @Relationship var cardArts: [CardArt] = []
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Bank(name: "Chace"),
        Bank(name: "American Express"),
    ]
    
}
