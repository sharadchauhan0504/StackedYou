//
//  BookTicketViewModel.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import Foundation
import StackedYou

class BookTicketViewModel {
    
    lazy var stackedViews: [StackedYouViewDataSource] = {
        return [
            AmountSelectionView(frame: .zero),
            SubscriptionSelectionView(frame: .zero),
            CardSelectionView(frame: .zero)
        ]
    }()
    
}
