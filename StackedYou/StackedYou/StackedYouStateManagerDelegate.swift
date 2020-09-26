//
//  StackedYouStateManagerDelegate.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import Foundation

public protocol StackedYouStateManagerDelegate: class {
    func changeState(_ state: StackedYouCurrentState)
}
