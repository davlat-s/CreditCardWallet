import XCTest

extension XCUIApplication {
    private enum Identifiers {
        static let plusButton = "plusButton"
        static let cardNameTextField = "cardNameTextField"
    }

    var plusButtonToolbar: XCUIElement {
        buttons[Identifiers.plusButton]
    }

    var cardNameTextFieldForm: XCUIElement {
        textFields[Identifiers.cardNameTextField]
    }
    
    /// Taps the Add Card (+) button, asserting it exists first.
    func clickPlusButtonToolbar(file: StaticString = #file, line: UInt = #line) {
        let button = self.plusButtonToolbar.firstMatch
        XCTAssertTrue(button.exists, "\(button.description) must exist", file: file, line: line)
        button.tap()
    }
    
    func verifyCardNameTextField(file: StaticString = #file, line: UInt = #line) {
        let textField = self.cardNameTextFieldForm
        XCTAssertTrue(textField.waitForExistence(timeout: 5),
                      "cardNameTextField must exist",
                      file: file,
                      line: line)    }
}
