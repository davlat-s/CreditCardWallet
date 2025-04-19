import XCTest
@testable import CreditCardLibrary

final class ModelTests: XCTestCase {
    
    func testCreditCardInitialization() {
        let card = CreditCard(
            name: "Sapphire Preferred",
            creditLimit: 10000,
            openDate: .now,
            isBusiness: false,
            isChargeCard: false,
            lastDigits: "1234"
        )
        
        XCTAssertEqual(card.name, "Sapphire Preferred")
        XCTAssertEqual(card.creditLimit, 10000)
        XCTAssertEqual(card.lastDigits, "1234")
        XCTAssertFalse(card.isBusiness)
    }
    
    func testDeepCopyPreservesValues() {
        let card = CreditCard(name: "Platinum", creditLimit: 15000, openDate: .now, isBusiness: true, isChargeCard: false, lastDigits: "4321")
        let copy = card.deepCopy()
        
        XCTAssertEqual(copy.name, card.name)
        XCTAssertEqual(copy.creditLimit, card.creditLimit)
        XCTAssertEqual(copy.lastDigits, card.lastDigits)
        XCTAssertNil(copy.bank) // no relationship expected
    }


    func testCreditCardSizeComputation() {
        let width = 300.0
        let expectedHeight = (width / 8.56) * 5.389
        XCTAssertEqual(CreditCard.getHeight(width: width), expectedHeight, accuracy: 0.01)
    }

    func testReturnNewCreditCardDefaults() {
        let card = CreditCard.returnNewCreditCard()
        XCTAssertTrue(card.name.isEmpty)
        XCTAssertTrue(card.lastDigits.isEmpty)
        XCTAssertNil(card.bank)
        XCTAssertNil(card.creditLimit)
    }

    func testLoadBankCardArtData() {
        let data = loadBankCardArtData()
        XCTAssertNotNil(data)
        XCTAssertFalse(data!.isEmpty)
    }

    func testPromotionSampleData() {
        let promos = Promotion.sampleData
        XCTAssertFalse(promos.isEmpty)
        for promo in promos {
            XCTAssertFalse(promo.details.isEmpty)
        }
    }

    func testBonusSampleData() {
        let bonuses = Bonus.sampleData
        XCTAssertFalse(bonuses.isEmpty)
        for bonus in bonuses {
            XCTAssertFalse(bonus.details.isEmpty)
        }
    }

    func testHistoryEntryInitialization() {
        let date = Date()
        let entryText = "Test history entry"
        let history = HistoryEntry(date: date, entry: entryText)
        XCTAssertEqual(history.entry, entryText)
        XCTAssertEqual(history.date, date)
    }

    func testCardArtBankNameFallback() {
        let art = CardArt(assetID: "xyz", bank: nil)
        XCTAssertEqual(art.bankName, "No Bank")
    }

    func testPaymentProcessorSampleData() {
        let pps = PaymentProcessor.sampleData
        XCTAssertGreaterThanOrEqual(pps.count, 4)
        let names = pps.map { $0.name }
        XCTAssertTrue(names.contains("Visa"))
    }
}
