//
//  StackedYouErrors.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import Foundation

enum StackedYouErrors: Error {
    case minimumViewsRequired
    
    var message: String {
        switch self {
        case .minimumViewsRequired: return "Invalid number of views. To create a stack please provide minimum of two views or else try some other framework for your flat screen!"
        }
    }
}
