//
//  File.swift
//  
//
//  Created by GG on 19/10/2020.
//

import UIKit
import LabelExtension
import FontExtension
import ATAConfiguration

protocol CloseDelegate: NSObjectProtocol {
    func close(_ view: UIView)
}

class BorderedErrorView: UIView {
    static func load() -> BorderedErrorView {
        Bundle.module.loadNibNamed("BorderedErrorView", owner: nil, options: nil)!.first! as! BorderedErrorView
    }
    static var configuration: ATAConfiguration!
    @IBOutlet weak var closeButton: UIButton!  {
        didSet {
            closeButton.tintColor = BorderedErrorView.configuration.palette.primary
        }
    }

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var coloredBackgroundView: UIView!  {
        didSet {
            coloredBackgroundView.backgroundColor = BorderedErrorView.configuration.palette.primary
        }
    }

    @IBOutlet weak var strokedBackgroundView: UIView!  {
        didSet {
            strokedBackgroundView.cornerRadius = 5.0
            strokedBackgroundView.layer.borderWidth = 1.0
            strokedBackgroundView.layer.borderColor = BorderedErrorView.configuration.palette.primary.cgColor
            strokedBackgroundView.backgroundColor = .white
        }
    }
    weak var closeDelegate: CloseDelegate?
    
    @IBAction func close() {
        closeDelegate?.close(self)
    }
    
    /// configure with a text and a close button to dimiss tha view
    func configure(_ text: String, delegate: CloseDelegate) {
        closeDelegate = delegate
        errorLabel.set(text: text, for: .footnote, textColor: BorderedErrorView.configuration.palette.primary)
    }
    
    /// configure only with an error. The closeBUtton is hidden
    func configure(_ text: String) {
        closeButton.isHidden = true
        errorLabel.set(text: text, for: .footnote, textColor: BorderedErrorView.configuration.palette.primary)
    }
}
