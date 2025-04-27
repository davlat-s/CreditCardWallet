import XCTest

struct Form {
    private enum ID {
        static let selectCardImageButton = "SelectCardImageButton"
        static let cardNameTextField = "cardNameTextField"
        static let annualFeeNumberField = "annualFeeNumberField"
        static let creditLimitNumberField = "creditLimitNumberField"
        static let lastDigitsTextField = "lastDigitsTextField"
        static let bankPicker = "bankPicker"
        static let openDatePicker = "openDatePicker"
        static let chargeCardToggle = "chargeCardToggle"
        static let businessToggle = "businessToggle"
        static let addPromotionButton = "addPromotionButton"
        static let addBonusButton = "addBonusButton"
        static let closeCardButton = "closeCardButton"
        static let discardButton = "discardButton"
        static let addCardButton = "addCardButton"
    }
    
    let app: XCUIApplication

    // MARK: - Element Getters
    var selectCardImageButton: XCUIElement {
        app.buttons.matching(identifier: ID.selectCardImageButton).firstMatch
    }
    var addPromotionButton: XCUIElement {
        app.buttons.matching(identifier: ID.addPromotionButton).firstMatch
    }
    var addBonusButton: XCUIElement {
        app.buttons.matching(identifier: ID.addBonusButton).firstMatch
    }
    var closeCardButton: XCUIElement {
        app.buttons.matching(identifier: ID.closeCardButton).firstMatch
    }
    var discardButton: XCUIElement {
        app.buttons.matching(identifier: ID.discardButton).firstMatch
    }
    var addCardButton: XCUIElement {
        app.buttons.matching(identifier: ID.addCardButton).firstMatch
    }

    var cardNameTextField: XCUIElement {
        app.textFields.matching(identifier: ID.cardNameTextField).firstMatch
    }
    var annualFeeNumberField: XCUIElement {
        app.textFields.matching(identifier: ID.annualFeeNumberField).firstMatch
    }
    var creditLimitNumberField: XCUIElement {
        app.textFields.matching(identifier: ID.creditLimitNumberField).firstMatch
    }
    var lastDigitsTextField: XCUIElement {
        app.textFields.matching(identifier: ID.lastDigitsTextField).firstMatch
    }

    var bankPicker: XCUIElement {
        app.popUpButtons.matching(identifier: ID.bankPicker).firstMatch
    }
    var openDatePicker: XCUIElement {
        app.datePickers.matching(identifier: ID.openDatePicker).firstMatch
    }

    var chargeCardToggle: XCUIElement {
        app.switches.matching(identifier: ID.chargeCardToggle).firstMatch
    }
    var businessToggle: XCUIElement {
        app.switches.matching(identifier: ID.businessToggle).firstMatch
    }

    // MARK: - Assertions & Actions
    // Button assertions and actions
    func assertButtonExists(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        let appeared = element.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ \(element.identifier) should exist", file: file, line: line)
    }
    func assertButtonEnabled(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(element.isEnabled, "⚠️ \(element.identifier) should be enabled", file: file, line: line)
    }
    func assertButtonDisabled(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(element.isEnabled, "⚠️ \(element.identifier) should be disabled", file: file, line: line)
    }
    func tapButton(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        assertButtonExists(element, file: file, line: line)
        assertButtonEnabled(element, file: file, line: line)
        element.tap()
    }

    // TextField assertions and actions
    func assertTextFieldExists(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        let appeared = element.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ \(element.identifier) should exist", file: file, line: line)
    }
    func assertTextFieldEnabled(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(element.isEnabled, "⚠️ \(element.identifier) should be enabled", file: file, line: line)
    }
    func typeText(_ element: XCUIElement, _ text: String, file: StaticString = #file, line: UInt = #line) {
        assertTextFieldExists(element, file: file, line: line)
        assertTextFieldEnabled(element, file: file, line: line)
        element.tap()
        element.typeText(text)
    }

    // Picker and DatePicker assertions and actions
    func assertPickerExists(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        let appeared = element.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ \(element.identifier) should exist", file: file, line: line)
    }
    func selectPickerValue(_ element: XCUIElement, _ value: String, file: StaticString = #file, line: UInt = #line) {
        assertPickerExists(element, file: file, line: line)
        element.click()
        element.menuItems[value].click()
    }
    func assertDatePickerExists(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        let appeared = element.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ \(element.identifier) should exist", file: file, line: line)
    }
    func setDatePickerValue(_ element: XCUIElement, _ date: Date, file: StaticString = #file, line: UInt = #line) {
        assertDatePickerExists(element, file: file, line: line)
        element.tap()
        // Further implementation depends on date picker type
    }

    // Toggle assertions and actions
    func assertToggleExists(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        let appeared = element.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ \(element.identifier) should exist", file: file, line: line)
    }
    func assertToggleOn(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(element.value as? String, "1", "⚠️ \(element.identifier) should be on", file: file, line: line)
    }
    func assertToggleOff(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(element.value as? String, "0", "⚠️ \(element.identifier) should be off", file: file, line: line)
    }
    func toggle(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        assertToggleExists(element, file: file, line: line)
        element.click()
    }

}
