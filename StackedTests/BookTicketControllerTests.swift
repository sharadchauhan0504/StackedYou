//
//  BookTicketControllerTests.swift
//  StackedTests
//
//  Created by Sharad on 26/09/20.
//

import XCTest
@testable import Stacked

class BookTicketControllerTests: XCTestCase {

    var viewModel: BookTicketViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = BookTicketViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testMinimumStackedViews() {
        XCTAssertTrue(viewModel.stackedViews.count > 1, "To create stacked views, number of views should be greater than 1")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
