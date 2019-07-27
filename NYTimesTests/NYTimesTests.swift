//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPopulars() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var fetchExpectation: XCTestExpectation?
        
        let viewModel = MostPopularViewModel()
        
        viewModel.arrPopulars.bind { (populars) in
            fetchExpectation?.fulfill()
        }
        
        XCTContext.runActivity(named: "Fetch Popular Results") { _ in
            
            waitForTimeout(for: 10,
                           callback: { (expectation) in
                            fetchExpectation = expectation
                            viewModel.fetchNewSearchResults(forDays: 1, searchText: nil)
            })
        }
    }
}
