import XCTest


struct CardGrid {
    private enum ID {
        static func cardCell(_ uuid: String) -> String { "CardCell_\(uuid)" }
    }
    
    let app: XCUIApplication



    func cardCell(_ uuid: String) -> XCUIElement {
        return app
            .descendants(matching: .any)
            .matching(identifier: ID.cardCell(uuid))
            .firstMatch
    }

    func assertCardCellExistsWithUUID(_ uuid: String, file: StaticString = #file, line: UInt = #line) {
        let cell = cardCell(uuid)
        let appeared = cell.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ Card cell '\(uuid)' should exist", file: file, line: line
        )
    }

    func singleClickCard(_ uuid: String, file: StaticString = #file, line: UInt = #line) {
        assertCardCellExistsWithUUID(uuid, file: file, line: line)
        cardCell(uuid).click()
    }

    func doubleClickCard(_ uuid: String, file: StaticString = #file, line: UInt = #line) {
        assertCardCellExistsWithUUID(uuid, file: file, line: line)
        cardCell(uuid).doubleClick()
    }

    /// Asserts that an element with the given name exists.
    func assertCardName(_ name: String, file: StaticString = #file, line: UInt = #line) {
        let predicate = NSPredicate(format: "label == %@", name)
        let element = app.descendants(matching: .any)
            .matching(predicate)
            .firstMatch
        let appeared = element.waitForExistence(timeout: 5)
        XCTAssertTrue(appeared, "⚠️ Expected to find element with label '\(name)'", file: file, line: line)
    }
}
