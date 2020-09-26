//
//  BookTicketControllerUITests.swift
//  StackedUITests
//
//  Created by Sharad on 26/09/20.
//

import XCTest

class BookTicketControllerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }


    func testBookTicketStackedUIFlow() {
        app.launch()
        
        //BookTicketController
        let bookTicketControllerView = app.otherElements["controller--BookTicketController"]
        XCTAssertTrue(bookTicketControllerView.exists)
        
        wait(for: 1.0)
        
        let stackMaintainerView = bookTicketControllerView.otherElements["frameworkview--StackMaintainerView"]
        XCTAssertTrue(stackMaintainerView.exists, "StackMaintainerView does not exists")
        
        wait(for: 1.0)
        
        //AmountSelectionView
        let amountSelectionView         = stackMaintainerView.otherElements["customview--AmountSelectionView"]
        XCTAssertTrue(amountSelectionView.exists, "AmountSelectionView does not exists")

        let timeSelectionCollectionView = amountSelectionView.collectionViews["collectionview--timeSelectionCollectionView"]
        XCTAssertTrue(timeSelectionCollectionView.exists, "timeSelectionCollectionView does not exists")
        timeSelectionCollectionView.swipeLeft()
        timeSelectionCollectionView.swipeRight()
        
        wait(for: 2.0)
        
        // Get collection cell which is has the text label inside is '10:00'
        let selectedTimeText  = "10:00"
        let timeSelectionCell = timeSelectionCollectionView.staticTexts[selectedTimeText]
        timeSelectionCell.tap()
        XCTAssert(timeSelectionCell.exists, "timeSelectionCell with text \(selectedTimeText) does not exist")

        let selectedTimeLabel = amountSelectionView.staticTexts[selectedTimeText]
        XCTAssert(selectedTimeLabel.exists, "selectedTimeLabel with text \(selectedTimeText) does not exist")

        let addMunchiesButton = amountSelectionView.buttons["button--addMunchiesButton"]
        XCTAssertTrue(addMunchiesButton.exists, "addMunchiesButton does not exists")
        addMunchiesButton.tap()
        
        wait(for: 1.0)
        
        //SubscriptionSelectionView
        let subscriptionSelectionView    = stackMaintainerView.otherElements["customview--SubscriptionSelectionView"]
        XCTAssertTrue(subscriptionSelectionView.exists, "SubscriptionSelectionView does not exists")

        let addMunchiesInformationText   = "Add munchies to your bag and beat the Queue!"
        let addMunchiesInformationLabel  = subscriptionSelectionView.staticTexts[addMunchiesInformationText]
        XCTAssert(addMunchiesInformationLabel.exists, "addMunchiesInformationLabel with text \(addMunchiesInformationText) does not exist")

        let deliveryInformationLabelText = "We'll bring it you!"
        let deliveryInformationLabel     = subscriptionSelectionView.staticTexts[deliveryInformationLabelText]
        XCTAssert(deliveryInformationLabel.exists, "deliveryInformationLabel with text \(deliveryInformationLabelText) does not exist")

        let proceedCheckoutButton        = subscriptionSelectionView.buttons["button--proceedCheckoutButton"]
        XCTAssertTrue(proceedCheckoutButton.exists, "proceedCheckoutButton does not exists")
        proceedCheckoutButton.tap()
        
        wait(for: 1.0)
        
        //CardSelectionView
        let cardSelectionView            = stackMaintainerView.otherElements["customview--CardSelectionView"]
        XCTAssertTrue(cardSelectionView.exists, "CardSelectionView does not exists")
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.collectionViews["collectionview--timeSelectionCollectionView"].staticTexts["12:30"]/*[[".otherElements[\"controller--BookTicketController\"]",".otherElements[\"frameworkview--StackMaintainerView\"]",".otherElements[\"customview--AmountSelectionView\"].collectionViews[\"collectionview--timeSelectionCollectionView\"]",".cells.staticTexts[\"12:30\"]",".staticTexts[\"12:30\"]",".collectionViews[\"collectionview--timeSelectionCollectionView\"]"],[[[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/.swipeLeft()
        app/*@START_MENU_TOKEN@*/.collectionViews["collectionview--timeSelectionCollectionView"].staticTexts["11:00"]/*[[".otherElements[\"controller--BookTicketController\"]",".otherElements[\"frameworkview--StackMaintainerView\"]",".otherElements[\"customview--AmountSelectionView\"].collectionViews[\"collectionview--timeSelectionCollectionView\"]",".cells.staticTexts[\"11:00\"]",".staticTexts[\"11:00\"]",".collectionViews[\"collectionview--timeSelectionCollectionView\"]"],[[[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let discountStaticLabelText      = "Discount"
        let discountStaticLabel          = cardSelectionView.staticTexts[discountStaticLabelText]
        XCTAssert(discountStaticLabel.exists, "discountStaticLabel with text \(discountStaticLabelText) does not exist")

        let payableAmountStaticLabelText = "Payable Amount"
        let payableAmountStaticLabel     = cardSelectionView.staticTexts[payableAmountStaticLabelText]
        XCTAssert(payableAmountStaticLabel.exists, "payableAmountStaticLabel with text \(payableAmountStaticLabelText) does not exist")
        
        wait(for: 2.0)
        cardSelectionView.tap()
        wait(for: 2.0)
        subscriptionSelectionView.tap()
        wait(for: 2.0)
        
        app.terminate()
    }

}
