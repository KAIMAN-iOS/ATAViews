//
//  ViewController.swift
//  iosExample
//
//  Created by GG on 11/01/2021.
//

import UIKit
import ATAViews
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let card: ATACard = ATACard.create()
        view.addSubview(card)
        card.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview().inset(8)
        }
        card.configure(Conf(), display: Display())
    }
}

struct Conf: ATACardConfigurable {
    var title: String { "1001TAXIS\nCourses immédiates" }
    
    var subtitle: String?  { "sans engagement" }
    
    var items: [ATACardItemConfigurable] {
        [Item(title: "Courses transmises", subtitle: "24854"),
        Item(title: "Période essai offerte", subtitle: "3 mois"),
        Item(title: "Tarif après essai", subtitle: "4,99€")]
    }
}

struct Item: ATACardItemConfigurable {
    var title: String
    var subtitle: String?
}

struct Display: ATACardItemdisplayable {
    var cicleColor: UIColor { #colorLiteral(red: 0.9639044404, green: 0.7331302762, blue: 0.3017231822, alpha: 1) }
    var backgroundColor: UIColor { #colorLiteral(red: 0.09803921729, green: 0.09803921729, blue: 0.09803921729, alpha: 1) }
    var firstItemTitleColor: UIColor { #colorLiteral(red: 0.3411764801, green: 0.721568644, blue: 0.650980413, alpha: 1) }
    var secondItemTitleColor: UIColor { #colorLiteral(red: 0.3137255013, green: 0.4039215744, blue: 0.5333333611, alpha: 1) }
    var thirdItemTitleColor: UIColor { #colorLiteral(red: 0.6549019814, green: 0.360784322, blue: 0.4745098054, alpha: 1) }
}

