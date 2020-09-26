//
//  SubscriptionSelectionView.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import UIKit
import StackedYou

class SubscriptionSelectionView: UIView {

    //MARK:- IBOutlets
    @IBOutlet weak var munchiesSelectionContainerView: UIView!
    @IBOutlet weak var proceedCheckoutButton: UIButton! {
        didSet {
            proceedCheckoutButton.accessibilityIdentifier = "button--proceedCheckoutButton"
            proceedCheckoutButton.backgroundColor = .white
            proceedCheckoutButton.setTitleColor(.warmPink, for: .normal)
            proceedCheckoutButton.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        }
    }
    @IBOutlet weak var addMunchiesInformationLabel: UILabel!
    @IBOutlet weak var deliveryInformationLabel: UILabel!
    @IBOutlet weak var addMunchiesCollectionView: UICollectionView! {
        didSet {
//            addMunchiesCollectionView.registerNib(type: TimeSelectionCollectionCell.self)
//            addMunchiesCollectionView.delegate   = self
//            addMunchiesCollectionView.dataSource = self
        }
    }
    
    weak var stateManagerDelegate: StackedYouStateManagerDelegate?
    
    private var currentState: StackedYouCurrentState = .none {
        didSet {
            manageUIBasedOnState()
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI testing
        accessibilityIdentifier = "customview--SubscriptionSelectionView"
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
        let idenitifier = String(describing: SubscriptionSelectionView.self)
        let xib = UINib(nibName: idenitifier, bundle: Bundle.main)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    private func initialSetup() {
       
        backgroundColor = .warmPink
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
    
    private func manageUIBasedOnState() {
        switch currentState {
        case .visible, .none: setVisibleOrNoneStateForUIElements()
        case .background: setBackgroundStateForUIElements()
        }
    }
    
    private func setBackgroundStateForUIElements() {
        addMunchiesInformationLabel.animateAlpha(0.0, 0.35, 0.0, completion: { [weak self] in
            self?.addMunchiesInformationLabel.text = "Popcorn, Coke, Nachos, Burger... +1 more"
            self?.addMunchiesInformationLabel.animateAlpha(1.0, 0.35, completion: nil)
        })
        deliveryInformationLabel.animateAlpha(0.0, 0.35, 0.0, completion: { [weak self] in
            self?.deliveryInformationLabel.text = "Pay ₹1,275.0"
            self?.deliveryInformationLabel.animateAlpha(1.0, 0.35, completion: nil)
        })
        proceedCheckoutButton.animateAlpha(0.0, 0.5, 0.0, completion: nil)
        munchiesSelectionContainerView.animateAlpha(0.0, 1.0, completion: nil)
    }
    
    private func setVisibleOrNoneStateForUIElements() {
        addMunchiesInformationLabel.animateAlpha(0.0, 0.35, 0.0, completion: { [weak self] in
            self?.addMunchiesInformationLabel.text = "Add munchies to your bag and beat the Queue!"
            self?.addMunchiesInformationLabel.animateAlpha(1.0, 0.35, completion: nil)
        })
        deliveryInformationLabel.animateAlpha(0.0, 0.35, 0.0, completion: { [weak self] in
            self?.deliveryInformationLabel.text = "We'll bring it you!"
            self?.deliveryInformationLabel.animateAlpha(1.0, 0.35, completion: nil)
        })
        proceedCheckoutButton.animateAlpha(1.0, 0.5, 0.0, completion: nil)
        munchiesSelectionContainerView.animateAlpha(1.0, 1.0, completion: nil)
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
    
    //MARK:- Button actions
    @IBAction func proceedCheckoutButtonAciton(_ sender: UIButton) {
        expandNextStackedView()
    }
}

//MARK:- Extensions
extension SubscriptionSelectionView: StackedYouViewDataSource {
    
    var headerHeight: CGFloat {
        250.0
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

