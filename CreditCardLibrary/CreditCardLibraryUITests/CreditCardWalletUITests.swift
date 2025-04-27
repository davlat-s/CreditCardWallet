import XCTest

final class CreditCardWalletUITests: XCTestCase {

    var app: XCUIApplication!

    // MARK: - Shared test data
    static var baseCardName: String!
    static var cardName: String!
    static var creditLimit: String!
    static var lastDigits: String!
    static var bankName: String!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAddThenDeleteCreditCard() throws {
        let form = Form(app: app)
        let toolbar = Toolbar(app: app)
        let grid = CardGrid(app: app)
        let detail = CardDetail(app: app)
        
        let baseCardName = "Sapphire Reserve"
        let cardName = "\(baseCardName)-\(UUID().uuidString.prefix(4))"
        let creditLimit = "5000"
        let lastDigits = "3645"
        let bank = "Chase"
        
        // Store values for use in other tests
        Self.baseCardName = baseCardName
        Self.cardName = cardName
        Self.creditLimit = creditLimit
        Self.lastDigits = lastDigits
        Self.bankName = bank
        
        // Adding Credit Card
        toolbar.tapPlusButton()
        form.assertButtonDisabled(form.addCardButton)
        form.typeText(form.cardNameTextField, cardName)
        form.typeText(form.creditLimitNumberField, creditLimit)
        form.typeText(form.lastDigitsTextField, lastDigits)
        form.selectPickerValue(form.bankPicker, bank)
        form.tapButton(form.addCardButton)
        
        // Verifying toolbar button behavior
        toolbar.searchFor(cardName)
        grid.assertCardName(cardName)
        toolbar.assertEditCardButtonDisabled()
        toolbar.assertDeleteCardButtonDisabled()
        grid.singleClickCardName(cardName)
        toolbar.assertEditCardButtonEnabled()
        toolbar.assertDeleteCardButtonEnabled()
        
        // Verifying DetailView
        grid.doubleClickCardName(cardName)
        detail.tapShowHistoryButton()
        detail.tapHideHistoryButton()
        
        // Editing Credit Card
        
        
        // Verifying edits
        
        
        // Deleting Credit Card
        toolbar.tapBackButton()
        grid.singleClickCardName(cardName)
        toolbar.tapDeleteCardButton()
    }
}
