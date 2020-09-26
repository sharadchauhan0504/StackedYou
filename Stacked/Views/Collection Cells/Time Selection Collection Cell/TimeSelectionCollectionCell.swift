//
//  TimeSelectionCollectionCell.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import UIKit

struct TimeSelectionModel {
    let time: String
    var isSelected = false
}

class TimeSelectionCollectionCell: UICollectionViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.addCornerRadius(radius: 8.0)
        }
    }
    @IBOutlet weak var backgroundShadowView: UIView! {
        didSet {
            backgroundShadowView.addShadow(radius: 4.0, height: 0.0, opacity: 0.5, shadowColor: .white)
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK:- Public variable
    var timeSelectionData: TimeSelectionModel? = nil {
        didSet {
            setTimeData()
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- Private methods
    private func setTimeData() {
        guard let data = timeSelectionData else {return}
        timeLabel.text = data.time
        data.isSelected ? (containerView.backgroundColor = .warmPink) : (containerView.backgroundColor = .black)
    }
}
