import XCTest

struct Sidebar {
    private enum ID{
        static let category_all = "category_all"
        static let category_personal = "category_personal"
        static let category_business = "category_business"
        static let category_closed = "category_closed"
        static let category_charts = "category_charts"
    }
    
    let app: XCUIApplication

    // MARK: - Element Getters
    var allCategoryButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.category_all)
            .firstMatch
    }
    var personalCategoryButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.category_personal)
            .firstMatch
    }
    var businessCategoryButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.category_business)
            .firstMatch
    }
    var closedCategoryButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.category_closed)
            .firstMatch
    }
    var chartsCategoryButton: XCUIElement {
        app.buttons
            .matching(identifier: ID.category_charts)
            .firstMatch
    }

    // MARK: - Actions
    func tapAllCategory(file: StaticString = #file, line: UInt = #line) {
        let btn = allCategoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'All' category button should exist", file: file, line: line)
        btn.click()
    }
    func tapPersonalCategory(file: StaticString = #file, line: UInt = #line) {
        let btn = personalCategoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'Personal' category button should exist", file: file, line: line)
        btn.click()
    }
    func tapBusinessCategory(file: StaticString = #file, line: UInt = #line) {
        let btn = businessCategoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'Business' category button should exist", file: file, line: line)
        btn.click()
    }
    func tapClosedCategory(file: StaticString = #file, line: UInt = #line) {
        let btn = closedCategoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'Closed' category button should exist", file: file, line: line)
        btn.click()
    }
    func tapChartsCategory(file: StaticString = #file, line: UInt = #line) {
        let btn = chartsCategoryButton
        XCTAssertTrue(btn.waitForExistence(timeout: 5), "⚠️ 'Charts' category button should exist", file: file, line: line)
        btn.click()
    }
}
