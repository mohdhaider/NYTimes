//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import XCTest

class NYTimesUITests: XCTestCase {

    var application:XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        XCTContext.runActivity(named: "App Launch") { _ in
            
            continueAfterFailure = false
            
            application = XCUIApplication()
            application.launch()
        }
    }

    override func tearDown() {
        
        application = nil
    }

    func testSearchPopulars() {

        XCTContext.runActivity(named: "Popular Screen Screen") { _ in
            
            let populartableTable = application.tables["popularTable"]
            
            waitForVisible(populartableTable, timeout: 5)
            
            XCTContext.runActivity(named: "Swipe Up", block: { _ in
                
                let popularTitle = populartableTable.children(matching: .cell).element(boundBy: 0).staticTexts["PopularTitle"]
                
                waitForVisible(popularTitle, timeout: 5)
                
                popularTitle.swipeUp()
            })
            
            XCTContext.runActivity(named: "Swipe Down", block: { _ in
                
                let popularTitle = populartableTable.children(matching: .cell).element(boundBy: 4).staticTexts["PopularTitle"]
                
                waitForVisible(popularTitle, timeout: 5)
                
                popularTitle.swipeDown()
            })
        }
    }
}
