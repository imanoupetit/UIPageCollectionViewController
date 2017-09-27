
import XCTest

class PageBasedAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
        XCUIDevice.shared.orientation = .portrait
    }
    
    func testCollectionViewCellSelection() {
//        let cell0 = XCUIApplication().collectionViews.cells.elementBoundByIndex(0)
//
//        // Test that cell0 is selected by default
//        XCTAssert(cell0.selected)
//
//        let cell1 = XCUIApplication().collectionViews.cells.elementBoundByIndex(1)
//        cell1.tap()
//
//        // Test that cell0 is no more selected after a tap on cell1
//        XCTAssert(!cell0.selected)
//
//        // Test that cell1 is selected after a tap
//        XCTAssert(cell1.selected)
    }

    func testCollectionViewClickOnPageViewControllerReaction() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        collectionViewsQuery.staticTexts["February"].swipeLeft()

        let augustButton = collectionViewsQuery.staticTexts["August"]
        expectation(for: NSPredicate(format: "exists == YES"), evaluatedWith: augustButton, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        augustButton.swipeLeft()

        let decemberButton = collectionViewsQuery.staticTexts["December"]
        expectation(for: NSPredicate(format: "exists == YES"), evaluatedWith: decemberButton, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
        // MARK: Test that the "December" pagedViewController exists after scrolling & tapping on "December" collectionViewCell
        
        decemberButton.tap()
        let decemberLabel = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Interact").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["December"]
        XCTAssert(decemberLabel.exists)
        
        // MARK: Test that the "October" pagedViewController exists after scrolling / tapping on "October" collectionViewCell
        
        collectionViewsQuery.staticTexts["October"].tap()
        let octoberLabel = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Interact").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["October"]
        XCTAssert(octoberLabel.exists)
        
        // MARK: Test that the "November" pagedViewController exists after tapping on "November" collectionViewCell
        
        collectionViewsQuery.staticTexts["November"].tap()
        let novemberLabel = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Interact").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["November"]
        XCTAssert(novemberLabel.exists)
        
        // MARK: Test that the "December" pagedViewController does not exist anymore (even on pageControl cache)
        
        XCTAssert(!decemberLabel.exists)
    }

    func testPageViewControllerSwipeOnCollectionViewReaction() {
        let januaryLabel = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Interact").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["January"]
        januaryLabel.swipeLeft()
        
        // MARK: Test that "February" viewContyroller exists after a left swipe on "January" viewController
        
        let februaryLabel = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Interact").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["February"]
        XCTAssert(februaryLabel.exists)

        // MARK: Test that "March" viewContyroller exists after a left swipe on "February" viewController
        // MARK: Test that "January" viewContyroller does not exist anymore (even on pageControl cache)
        
        februaryLabel.swipeLeft()
        let marchLabel = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Interact").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["March"]
        XCTAssert(marchLabel.exists)
        XCTAssert(!januaryLabel.exists)
    }
    
    func testPageViewControllerClickOnPageIndicators() {
        let indicator = XCUIApplication().pageIndicators["page 1 of 12"]
        indicator.tap()
        expectation(for: NSPredicate(format: "exists == false"), evaluatedWith: indicator, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        XCUIDevice.shared.orientation = .portrait
        XCUIApplication().pageIndicators["page 1 of 12"].tap()
        
    }
    
    
}
