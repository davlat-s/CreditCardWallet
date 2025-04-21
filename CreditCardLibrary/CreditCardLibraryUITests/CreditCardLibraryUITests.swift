import XCTest

final class CreditCardLibraryUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAddCardHappyPath() throws {
        app.clickPlusButtonToolbar()
        app.verifyCardNameTextField()
    }
}
