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

    func testAddCard() throws {
        
        let form = Form(app: app)
        let toolbar = Toolbar(app: app)
        let grid = CardGrid(app: app)
        
        let baseCardName = "Sapphire Reserve"
        let cardName = "\(baseCardName)-\(UUID().uuidString.prefix(4))"
        let creditLimit = "5000"
        let lastDigits = "3645"
        let bank = "Chase"
        
        toolbar.tapPlusButton()
        form.typeText(form.cardNameTextField, cardName)
        form.typeText(form.creditLimitNumberField, creditLimit)
        form.typeText(form.lastDigitsTextField, lastDigits)
        form.selectPickerValue(form.bankPicker, bank)
        form.tapButton(form.addCardButton)
        toolbar.searchFor(cardName)
        grid.assertCardName(cardName)
    }
}
