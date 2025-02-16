import Foundation
import SwiftData

@Model
final class CardArt {
    var assetID: String
    @Relationship var bank: Bank?

    init(assetID: String, bank: Bank? = nil) {
        self.assetID = assetID
        self.bank = bank
    }
    
    static func returnNewCardArt() -> CardArt {
        return CardArt(assetID: "default")
    }
    
    static let sampleData = [
        CardArt(assetID: "American_Express-Personal-Platinum_Schwab"),
        CardArt(assetID: "American_Express-Personal-Platinum_Schwab")
    ]
    
}

extension CardArt {
    var bankName: String {
        bank?.name ?? "No Bank"
    }
}



