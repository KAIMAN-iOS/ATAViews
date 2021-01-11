//
//  File.swift
//  
//
//  Created by GG on 11/01/2021.
//

import UIKit
import Ampersand
import LabelExtension

protocol ATACardConfigurable {
    var title: String { get }
    var subtitle: String? { get }
    var items: [ATACardItemConfigurable] { get }
}

protocol ATACardItemConfigurable {
    var title: String { get }
    var subtitle: String? { get }
}

protocol ATACardItemdisplayable {
    var cicleColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var firstItemTitleColor: UIColor { get }
    var secondItemTitleColor: UIColor { get }
    var thirdItemTitleColor: UIColor { get }
}

class ATACard: UIView {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var outerCircle: UIView!
    @IBOutlet weak var innerCircle: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainSubtitle: UILabel!
    // stats
    @IBOutlet weak var firstItemTitle: UILabel!
    @IBOutlet weak var firstItemvalue: UILabel!
    @IBOutlet weak var secondItemTitle: UILabel!
    @IBOutlet weak var secondItemvalue: UILabel!
    @IBOutlet weak var thirdItemTitle: UILabel!
    @IBOutlet weak var thirdItemvalue: UILabel!
    
    
    func configure(_ data: ATACardConfigurable, display: ATACardItemdisplayable, cardCornerRadius: CGFloat = 10) {
        card.layer.cornerRadius = cardCornerRadius
        outerCircle.backgroundColor = display.cicleColor
        card.backgroundColor = display.backgroundColor
        innerCircle.backgroundColor = display.backgroundColor
        outerCircle.layer.cornerRadius = outerCircle.bounds.midY
        innerCircle.layer.cornerRadius = innerCircle.bounds.midY
        
        mainTitle.set(text: data.title, for: .title2, textColor: .white)
        mainSubtitle.set(text: data.subtitle, for: .callout, textColor: .white)
        for (index, item) in data.items.enumerated() {
            switch index {
            case 0:
                firstItemTitle.set(text: item.title, for: .subheadline, textColor: display.firstItemTitleColor)
                firstItemvalue.set(text: item.subtitle, for: .title2, textColor: .white)
                
            case 1:
                secondItemTitle.set(text: item.title, for: .subheadline, textColor: display.secondItemTitleColor)
                secondItemvalue.set(text: item.subtitle, for: .title2, textColor: .white)
                
            case 2:
                thirdItemTitle.set(text: item.title, for: .subheadline, textColor: display.thirdItemTitleColor)
                thirdItemvalue.set(text: item.subtitle, for: .title2, textColor: .white)
                
            default: ()
            }
        }
    }
}
