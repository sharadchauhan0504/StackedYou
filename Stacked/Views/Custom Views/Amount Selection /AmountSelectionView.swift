//
//  AmountSelectionView.swift
//  Stacked
//
//  Created by Sharad on 25/09/20.
//

import UIKit
import StackedYou

class AmountSelectionView: UIView {

    //MARK:- IBOutlets
    @IBOutlet weak var addMunchiesButton: UIButton! {
        didSet {
            addMunchiesButton.accessibilityIdentifier = "button--addMunchiesButton"
            addMunchiesButton.backgroundColor         = .warmPink
            addMunchiesButton.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        }
    }
    @IBOutlet weak var timeSelectionContainerView: UIView!
    @IBOutlet weak var selectedSeatLabel: UILabel!
    @IBOutlet weak var selectedTimeLabel: UILabel!
    @IBOutlet weak var timeSelectionCollectionView: UICollectionView! {
        didSet {
            timeSelectionCollectionView.accessibilityIdentifier = "collectionview--timeSelectionCollectionView"
            timeSelectionCollectionView.registerNib(type: TimeSelectionCollectionCell.self)
            timeSelectionCollectionView.delegate                = self
            timeSelectionCollectionView.dataSource              = self
        }
    }
    
    
    weak var stateManagerDelegate: StackedYouStateManagerDelegate?
    
    //MARK:- Private variables
    private var currentState: StackedYouCurrentState = .none {
        didSet {
            manageUIBasedOnState()
        }
    }
    private var staticTimeSelectionArray = [TimeSelectionModel]()
    private var previousSelectedIndexPath = IndexPath(item: 0, section: 0)
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //UI testing
        accessibilityIdentifier = "customview--AmountSelectionView"
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
        let idenitifier = String(describing: AmountSelectionView.self)
        let xib = UINib(nibName: idenitifier, bundle: Bundle.main)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    private func initialSetup() {
        updateSelectedSeatLabel("A14-A20")
        staticTimeSelectionArray = [
            TimeSelectionModel(time: "10:00", isSelected: false),
            TimeSelectionModel(time: "11:00", isSelected: false),
            TimeSelectionModel(time: "12:30", isSelected: false),
            TimeSelectionModel(time: "14:30", isSelected: false),
            TimeSelectionModel(time: "15:00", isSelected: false),
            TimeSelectionModel(time: "16:50", isSelected: false),
            TimeSelectionModel(time: "17:45", isSelected: false),
            TimeSelectionModel(time: "18:50", isSelected: false),
            TimeSelectionModel(time: "20:00", isSelected: false),
            TimeSelectionModel(time: "21:30", isSelected: false),
            TimeSelectionModel(time: "22:20", isSelected: false),
            TimeSelectionModel(time: "23:00", isSelected: false),
        ]
        selectedSeatLabel.alpha = 0.0
        selectedTimeLabel.alpha = 0.0
        backgroundColor = .black
        
        //Gestures
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
    
    private func setVisibleOrNoneStateForUIElements() {
        selectedTimeLabel.animateAlpha(0.0, 1.0, completion: nil)
        selectedSeatLabel.animateAlpha(0.0, 1.0, completion: nil)
        timeSelectionContainerView.animateAlpha(1.0, 1.0, completion: nil)
        addMunchiesButton.animateAlpha(1.0, 0.5, 0.25, completion: nil)
    }
    
    private func setBackgroundStateForUIElements() {
        selectedTimeLabel.animateAlpha(1.0, 1.0, 0.35, completion: nil)
        selectedSeatLabel.animateAlpha(1.0, 1.0, 0.35, completion: nil)
        timeSelectionContainerView.animateAlpha(0.0, 1.0, 0.35, completion: nil)
        addMunchiesButton.animateAlpha(0.0, 0.5, 0.0, completion: nil)
    }
    
    private func updateSelectedTimeLabel(_ time: String) {
        let attributedString = NSMutableAttributedString()
        attributedString
            .customFont("TIME: ", UIFont(name: "Avenir-Book", size: 14.0)!)
            .customFont(time, UIFont(name: "Avenir-Heavy", size: 14.0)!)
        selectedTimeLabel.attributedText = attributedString
    }
    
    private func updateSelectedSeatLabel(_ selectedSeat: String) {
        let attributedString = NSMutableAttributedString()
        attributedString
            .customFont("SEAT: ", UIFont(name: "Avenir-Book", size: 14.0)!)
            .customFont(selectedSeat, UIFont(name: "Avenir-Heavy", size: 14.0)!)
        selectedSeatLabel.attributedText = attributedString
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
    @IBAction func addMunchiesButtonAciton(_ sender: UIButton) {
        expandNextStackedView()
    }
}

//MARK:- CollectionView Extension
extension AmountSelectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        updateSelectedTimeLabel(staticTimeSelectionArray[indexPath.item].time)
        staticTimeSelectionArray[previousSelectedIndexPath.item].isSelected = false
        staticTimeSelectionArray[indexPath.item].isSelected = !staticTimeSelectionArray[indexPath.item].isSelected
        previousSelectedIndexPath                           = indexPath
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
                cell.transform = .identity
            }) { [weak self] (success) in
                self?.timeSelectionCollectionView.reloadData()
            }
        }
    }
    
}

extension AmountSelectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return staticTimeSelectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSelectionCollectionCell", for: indexPath) as! TimeSelectionCollectionCell
        cell.timeSelectionData = staticTimeSelectionArray[indexPath.item]
        return cell
    }
}

extension AmountSelectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.0, height: collectionView.bounds.height)
    }
}

//MARK:- Framework Extension
extension AmountSelectionView: StackedYouViewDataSource {

    var headerHeight: CGFloat {
        100.0
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
