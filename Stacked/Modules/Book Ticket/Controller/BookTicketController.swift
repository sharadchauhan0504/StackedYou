//
//  BookTicketController.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import UIKit
import StackedYou

class BookTicketController: UIViewController {

    //MARK:- Private variables
    private var stackedMantainerView: StackMaintainerView?
    private let viewModel = BookTicketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI testing
        view.accessibilityIdentifier = "controller--BookTicketController"
        view.backgroundColor = .royalBlue
        addViewsToStack()
    }

    //MARK:- Private methods
    private func addViewsToStack() {
        stackedMantainerView             = StackMaintainerView(frame: view.frame)
        stackedMantainerView?.accessibilityIdentifier = "frameworkview--StackMaintainerView"
        stackedMantainerView?.dataSource = self
        view.addSubview(stackedMantainerView!)
    }

}
//MARK:- Extensions
extension BookTicketController: StackedYouDataSource {
    
    func viewForStack() -> [StackedYouViewDataSource] {
        return viewModel.stackedViews
    }
}
