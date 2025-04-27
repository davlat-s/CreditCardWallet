import XCTest

struct CardDetail {
    let app: XCUIApplication
    private enum ID {
        static let showHistoryButton = "showHistory"
        static let hideHistoryButton = "hideHistory"
        
    }

    // MARK: - Element Getters
    var showHistoryButton: XCUIElement {
        app.buttons.matching(identifier: ID.showHistoryButton).firstMatch
    }
    var hideHistoryButton: XCUIElement {
        app.buttons.matching(identifier: ID.hideHistoryButton).firstMatch
    }

    // MARK: - Assertions
    func assertShowHistoryButtonExists(file: StaticString = #file, line: UInt = #line) {
        let btn = showHistoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'Show History' button should exist", file: file, line: line)
    }
    func assertHideHistoryButtonExists(file: StaticString = #file, line: UInt = #line) {
        let btn = hideHistoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'Hide History' button should exist", file: file, line: line)
    }

    // MARK: - Actions
    func tapShowHistoryButton(file: StaticString = #file, line: UInt = #line) {
        assertShowHistoryButtonExists(file: file, line: line)
        showHistoryButton.tap()
    }
    func tapHideHistoryButton(file: StaticString = #file, line: UInt = #line) {
        assertHideHistoryButtonExists(file: file, line: line)
        hideHistoryButton.tap()
    }
}
