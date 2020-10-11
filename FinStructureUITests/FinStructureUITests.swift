//
//  FinStructureUITests.swift
//  FinStructureUITests
//
//  Created by Rakibul Hasan on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import XCTest

class FinStructureUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    // UI Test for Search City Bar
    
    func testSearchCity(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Location"].tap()
        app.navigationBars["Saved Locations"].buttons["Search"].tap()
        let searchfield=app.searchFields["Search city"]
        searchfield.tap()
        XCTAssertTrue(searchfield.exists)
        
    }
    // UI Test for Add Title Bar
    func testAddNoteTitle(){

        let app = XCUIApplication()
        app.tabBars.buttons["Notes"].tap()
        let tapone=app.textFields["Notes Title"]
        tapone.tap()
        XCTAssertTrue(tapone.exists)


    }
    
    //UI Test for Error Message Check
    func testerrorCheck() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Location"].tap()
        app.navigationBars["Saved Locations"].buttons["Search"].tap()
        app.searchFields["Search city"].tap()
        app.navigationBars["Search for a city"].buttons["Saved Locations"].tap()
        let alert=app.alerts["City Not Found"]
        XCTAssertTrue(alert.exists)
        alert.buttons["Try again"].tap()

    }
    // UI Test for Navigating Different Scences
    func testScene(){
        
        let tabBarsQuery = XCUIApplication().tabBars
        let  x=tabBarsQuery.buttons["Weather"]
        x.tap()
        let y=tabBarsQuery.buttons["Location"]
        y.tap()
        let z=tabBarsQuery.buttons["Notes"]
        z.tap()
        let m=tabBarsQuery.buttons["More"]
        m.tap()
        XCTAssertTrue(x.exists)
        XCTAssertTrue(y.exists)
        XCTAssertTrue(z.exists)
        XCTAssertTrue(m.exists)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

}
