import Foundation
import SwiftData


@Model
final class Bank {
    @Attribute(.unique) var id: UUID
    
    @Attribute(.unique) var name: String        
    @Relationship var creditCards: [CreditCard] = []
    @Relationship var cardArts: [CardArt] = []
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    static func returnNewBank() -> Bank {
        return Bank(name: "")
    }
    
    static let sampleData = [
        Bank(name: "Chace"),
        Bank(name: "American Express"),
    ]
    
}
