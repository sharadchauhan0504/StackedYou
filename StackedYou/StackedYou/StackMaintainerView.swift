//
//  StackMaintainerView.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import UIKit

public class StackMaintainerView: UIView {
    
    //MARK:- Public variables
    public weak var dataSource: StackedYouDataSource? {
        didSet {
            initializeStackedViews()
        }
    }
    
    //MARK:- Private variables
    private var stackViews = [StackedYouViewDataSource]()
    
    //MARK:- Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK:- Private methods
    private func initializeStackedViews() {
        guard let data = dataSource else {return}
        assert(data.viewForStack().count > 1, StackedYouErrors.minimumViewsRequired.message)
        stackViews = data.viewForStack()
        
        stackViews.forEach { (stackedView) in
            addSubview(stackedView)
            stackedView.translatesAutoresizingMaskIntoConstraints             = false
            stackedView.leftAnchor.constraint(equalTo: leftAnchor).isActive   = true
            stackedView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            stackedView.heightAnchor.constraint(equalToConstant: bounds.height - stackedView.headerHeight).isActive = true
            stackedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            stackedView.transform = CGAffineTransform(translationX: 0.0, y: bounds.height)
            stackedView.stateManagerDelegate = self
        }
        
        guard let firstView = stackViews.first else {return}
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: [.curveEaseIn], animations: {
            firstView.currentStackedState = .visible
            firstView.transform           = .identity
        }, completion: nil)
    }
    
    private func maintainStackState(_ state: StackedYouCurrentState) {
        guard let indexOfVisibleView = stackViews.firstIndex(where: { $0.currentStackedState == .visible }) else {return}
        
        switch state {
        case .visible:
            guard indexOfVisibleView > 0 else {return}
            let currentVisibleView                 = stackViews[indexOfVisibleView]
            currentVisibleView.currentStackedState = .none
            let previousView                       = stackViews[indexOfVisibleView - 1]
            previousView.currentStackedState       = .visible
            currentVisibleView.collapseAnimation(bounds.height)
        case .background:
            let currentVisibleView                 = stackViews[indexOfVisibleView]
            currentVisibleView.currentStackedState = .background
            let nextStackedView                    = stackViews[indexOfVisibleView + 1]
            nextStackedView.currentStackedState    = .visible
            nextStackedView.expandAnimation()
        case .none:
            guard indexOfVisibleView > 0 else {return}
            let currentVisibleView                 = stackViews[indexOfVisibleView]
            currentVisibleView.currentStackedState = .none
            let previousView                       = stackViews[indexOfVisibleView - 1]
            previousView.currentStackedState       = .visible
            currentVisibleView.collapseAnimation(bounds.height)
        }
        
    }
}

extension StackMaintainerView: StackedYouStateManagerDelegate {
    
    public func changeState(_ state: StackedYouCurrentState) {
        maintainStackState(state)
    }
    
}
