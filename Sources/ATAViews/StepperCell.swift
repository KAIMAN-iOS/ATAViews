//
//  StepperCell.swift
//  taxi.Chauffeur
//
//  Created by GG on 09/12/2020.
//

import UIKit
import LabelExtension
import Ampersand

protocol StepperDelegate: class {
    func stepperChanged(to value: Int)
}

class StepperCell: UICollectionViewCell {
    weak var delegate: StepperDelegate?
    @IBOutlet weak var title: UILabel!  {
        didSet {
            title.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var subtitle: UILabel!   {
        didSet {
            subtitle.adjustsFontForContentSizeCategory = true
        }
    }


    @IBOutlet weak var stepper: GMStepper!  {
        didSet {
            stepper.labelFont = .applicationFont(forTextStyle: .body)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func stepperChanged(_ sender: GMStepper) {
        delegate?.stepperChanged(to: Int(sender.value))
    }
}
