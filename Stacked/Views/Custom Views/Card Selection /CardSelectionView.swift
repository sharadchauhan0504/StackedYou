//
//  CardSelectionView.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import UIKit
import StackedYou

class CardSelectionView: UIView {

    //MARK:- IBoutlets
    @IBOutlet weak var discountStaticLabel: UILabel! {
        didSet {
            discountStaticLabel.textColor = .warmPink
            discountStaticLabel.font = UIFont(name: "Avenir-Regular", size: 14.0)
        }
    }
    @IBOutlet weak var discountValueLabel: UILabel! {
        didSet {
            discountValueLabel.textColor = .warmPink
            discountValueLabel.font = UIFont(name: "Avenir-Heavy", size: 14.0)
            discountValueLabel.text = "12%"
        }
    }
    @IBOutlet weak var payableAmountStaticLabel: UILabel! {
        didSet {
            payableAmountStaticLabel.textColor = .warmPink
            payableAmountStaticLabel.font = UIFont(name: "Avenir-Regular", size: 14.0)
        }
    }
    @IBOutlet weak var payableAmountValueLabel: UILabel! {
        didSet {
            payableAmountValueLabel.textColor = .warmPink
            payableAmountValueLabel.font = UIFont(name: "Avenir-Heavy", size: 14.0)
            payableAmountValueLabel.text = "₹1,121.12"
        }
    }
    @IBOutlet weak var backgroundAlphaView: UIView! {
        didSet {
            backgroundAlphaView.backgroundColor = .warmPink
            backgroundAlphaView.addCornerRadius(radius: 8.0)
        }
    }
    
    
    weak var stateManagerDelegate: StackedYouStateManagerDelegate?
    
    private var currentState: StackedYouCurrentState = .none
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI testing
        accessibilityIdentifier = "customview--CardSelectionView"
        loadNib()
        initialSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        guard subviews.isEmpty else {return}
        loadNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
    
    //MARK:- Private methods
    private func loadNib() {
        let idenitifier = String(describing: CardSelectionView.self)
        let xib = UINib(nibName: idenitifier, bundle: Bundle.main)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    private func initialSetup() {
        backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
        let edgeSwipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgeSwipeGesture(_:)) )
        edgeSwipeGesture.edges = .right
        addGestureRecognizer(edgeSwipeGesture)
    }
    
    @objc private func handleEdgeSwipeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            guard abs(recognizer.translation(in: self).x) > 80.0 else {return}
            handleGestureStates()
        default: break
        }
    }
    
    @objc private func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        handleGestureStates()
    }
    
    private func handleGestureStates() {
        switch currentState {
        case .visible: collapseCurrentVisibleStackedView()
        case .background: collapseUpperStackedView()
        case .none: break
        }
    }
    
    private func expandNextStackedView() {
        stateManagerDelegate?.changeState(.background)
    }
        
    private func collapseUpperStackedView() {
        stateManagerDelegate?.changeState(.visible)
    }
    
    private func collapseCurrentVisibleStackedView() {
        stateManagerDelegate?.changeState(.none)
    }
}

//MARK:- Extensions
extension CardSelectionView: StackedYouViewDataSource {

    var headerHeight: CGFloat {
        380.0
    }
    
    var currentStackedState: StackedYouCurrentState {
        get {
            currentState
        }
        set {
            currentState = newValue
        }
    }
    
}

