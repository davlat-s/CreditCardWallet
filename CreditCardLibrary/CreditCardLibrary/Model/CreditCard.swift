import Foundation
import SwiftData
import SwiftUI

@Model
class CreditCard {
    
    @Attribute(.unique) var id: String
    var cardName: String
    var bank: Bank
    var openDate: Date
    var image: Image {
        Image(imageName)
    }
    
    var annualFee: Int
    var dueDay: Int
    var creditLimit: Double?
    var isChargeCard: Bool
    var isBusiness: Bool
    var isClosed: Bool
    
    private var imageName: String
    
    init(id: String, cardName: String, bank: Bank, openDate: Date, annualFee: Int, dueDay: Int, creditLimit: Double? = nil, isChargeCard: Bool, isBusiness: Bool, isClosed: Bool, imageName: String) {
        self.id = id
        self.cardName = cardName
        self.bank = bank
        self.openDate = openDate
        self.annualFee = annualFee
        self.dueDay = dueDay
        self.creditLimit = creditLimit
        self.isChargeCard = isChargeCard
        self.isBusiness = isBusiness
        self.isClosed = isClosed
        self.imageName = imageName
    }
}
