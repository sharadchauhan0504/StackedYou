//
//  StackedYouDataSource.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import UIKit

public protocol StackedYouViewDataSource: UIView {
    var headerHeight: CGFloat { get }
    var currentStackedState: StackedYouCurrentState { get set }
    var stateManagerDelegate: StackedYouStateManagerDelegate? { get set }
    //func passDataToNextView() -> Any?
}

public protocol StackedYouDataSource: AnyObject {
    func viewForStack() -> [StackedYouViewDataSource]
}
