//
//  XCTestCaseExtensions.swift
//  StackedUITests
//
//  Created by Sharad on 26/09/20.
//

import XCTest

extension XCTestCase {

    //Add waiting for asynchronous calls
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "waiting")
        let when            = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }
}
