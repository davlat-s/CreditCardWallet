import XCTest


struct Toolbar {
    private enum ID {
        static let plusButton = "plusButton"
        static let editCardButton = "editCardButton"
        static let deleteCardButton = "deleteCardButton"
        static let searchField = "searchField"
    }
    
    let app: XCUIApplication

    // MARK: - Element Getters
    var plusButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.plusButton)
            .firstMatch
    }
    
    var editCardButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.editCardButton)
            .firstMatch
    }
    
    var deleteCardButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.deleteCardButton)
            .firstMatch
    }
    
    // MARK: - Assertions
    func assertPlusButtonExists(file: StaticString = #file, line: UInt = #line) {
        let btn = plusButton
        let appeared = btn.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "➕ button should exist", file: file, line: line)
    }
    
    func assertEditCardButtonExists(file: StaticString = #file, line: UInt = #line) {
        let btn = editCardButton
        let appeared = btn.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "✏️ Edit Card button should exist", file: file, line: line)
    }
    
    func assertDeleteCardButtonExists(file: StaticString = #file, line: UInt = #line) {
        let btn = deleteCardButton
        let appeared = btn.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "🗑️ Delete Card button should exist", file: file, line: line)
    }
    
    // MARK: - Actions
    func tapPlusButton(file: StaticString = #file, line: UInt = #line) {
        assertPlusButtonExists(file: file, line: line)
        assertPlusButtonEnabled(file: file, line: line)
        plusButton.tap()
    }
    
    func tapEditCardButton(file: StaticString = #file, line: UInt = #line) {
        assertEditCardButtonExists(file: file, line: line)
        assertEditCardButtonEnabled(file: file, line: line)
        editCardButton.tap()
    }
    
    func tapDeleteCardButton(file: StaticString = #file, line: UInt = #line) {
        assertDeleteCardButtonExists(file: file, line: line)
        assertDeleteCardButtonEnabled(file: file, line: line)
        deleteCardButton.tap()
    }
    

    // MARK: - Search
    var searchField: XCUIElement {
        app.searchFields["search"]
    }

    func searchFor(_ query: String, file: StaticString = #file, line: UInt = #line) {
        let field = searchField
        XCTAssertTrue(field.waitForExistence(timeout: 5), "🔍 Search field should be visible", file: file, line: line)
        field.tap()
        field.typeText(query)
        field.typeKey(.return, modifierFlags: [])
    }

    // MARK: - Enabled State Checks
    var isPlusButtonEnabled: Bool {
        plusButton.isEnabled
    }
    
    var isEditCardButtonEnabled: Bool {
        editCardButton.isEnabled
    }
    
    var isDeleteCardButtonEnabled: Bool {
        deleteCardButton.isEnabled
    }
    
    // MARK: - Enabled Assertions
    func assertPlusButtonEnabled(file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(isPlusButtonEnabled, "➕ button should be enabled", file: file, line: line)
    }
    
    func assertPlusButtonDisabled(file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(isPlusButtonEnabled, "➕ button should be disabled", file: file, line: line)
    }
    
    func assertEditCardButtonEnabled(file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(isEditCardButtonEnabled, "✏️ Edit Card button should be enabled", file: file, line: line)
    }
    
    func assertEditCardButtonDisabled(file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(isEditCardButtonEnabled, "✏️ Edit Card button should be disabled", file: file, line: line)
    }
    
    func assertDeleteCardButtonEnabled(file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(isDeleteCardButtonEnabled, "🗑️ Delete Card button should be enabled", file: file, line: line)
    }
    
    func assertDeleteCardButtonDisabled(file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(isDeleteCardButtonEnabled, "🗑️ Delete Card button should be disabled", file: file, line: line)
    }

}
