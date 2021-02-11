//
//  BasicTextFieldsView.swift
//  taxi.Chauffeur
//
//  Created by GG on 15/01/2021.
//

import UIKit
import UIViewExtension

public class BasicTextFieldsView: UIView {
    @IBOutlet weak var stackView: UIStackView!
    var textFields: [BorderedTextField] {
        stackView.arrangedSubviews.compactMap({ $0 as? BorderedTextField })
    }
    
    func configure(_ fields: [FieldTypeConfigurable], ratios: [CGFloat] = []) {
        switch fields.count {
        case 0: fatalError()
        case 1:
            let view: BorderedTextField = BorderedTextField.loadFromNib()
            view.configure(fields.first!)
            stackView.addArrangedSubview(view)
            stackView.distribution = .fill
            stackView.spacing = 0
            
        default:
            stackView.distribution = .fillProportionally
            stackView.spacing = 8
            let remaingWidth = stackView.bounds.width - 8 * (CGFloat(fields.count - 1))
            for (index, field) in fields.enumerated() {
                let view: BorderedTextField = BorderedTextField.loadFromNib()
                view.configure(field)
                stackView.addArrangedSubview(view)
                var ratio = remaingWidth / CGFloat(fields.count)
                if index < ratios.count {
                    ratio = ratios[index]
                }
                view.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width * ratio, height: frame.height))
                view.setContentHuggingPriority(UILayoutPriority.init(rawValue: Float(1000) * Float(1 - ratio)), for: .horizontal)
//                view.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: Float(1000) * Float(ratio)), for: .horizontal)
            }
        }
    }
}
