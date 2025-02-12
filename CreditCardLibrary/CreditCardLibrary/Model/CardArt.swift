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
    
    static let sampleData = [
        CardArt(assetID: "American_Express-Personal-Platinum_Schwab.png", bank: Bank.sampleData[0]),
        CardArt(assetID: "American_Express-Personal-Platinum_Schwab.png", bank: Bank.sampleData[1])
    ]
    
}

extension CardArt {
    var bankName: String {
        bank?.name ?? "No Bank"
    }
}



