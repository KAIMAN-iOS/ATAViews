//
//  StepperCell.swift
//  taxi.Chauffeur
//
//  Created by GG on 09/12/2020.
//

import UIKit
import LabelExtension
import Ampersand
import SnapKit

public protocol StepperDelegate: class {
    func stepperChanged(to value: Int)
}

public class StepperView: UIView {
    public static var stepperColor: UIColor = .black
    public static var stepperTextColor: UIColor = .white
    public weak var delegate: StepperDelegate?
    public lazy var title: UILabel! = {
        $0.adjustsFontForContentSizeCategory = true
        return $0
    } (UILabel())
    public lazy var subtitle: UILabel! = {
        $0.adjustsFontForContentSizeCategory = true
        return $0
    } (UILabel())

    public lazy var stepper: GMStepper! = {
        $0.labelFont = .applicationFont(forTextStyle: .body)
        $0.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
        return $0
    } (GMStepper())
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard stepper != nil else { return }
        stepper.labelBackgroundColor = StepperView.stepperColor
        stepper.buttonsBackgroundColor = StepperView.stepperColor
        stepper.labelTextColor = StepperView.stepperTextColor
        stepper.buttonsTextColor = StepperView.stepperTextColor
        stepper.snp.makeConstraints { make in
            make.height.equalTo(largeComponent ? 50 : 30)
            make.width.equalTo(largeComponent ? 130 : 100)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        loadObjects()
    }
    
    init() {
        super.init(frame: .zero)
        loadObjects()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadObjects()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadObjects()
    }
    
    public var largeComponent: Bool = true  {
        didSet {
            setNeedsLayout()
        }
    }
    
    func loadObjects() {
        let innerStackView = UIStackView()
        innerStackView.axis = .vertical
        innerStackView.distribution = .fill
        innerStackView.alignment = .fill
        innerStackView.addArrangedSubview(title)
        innerStackView.addArrangedSubview(subtitle)
        
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.addArrangedSubview(innerStackView)
        stackView.addArrangedSubview(stepper)
        stepper.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(130)
        }
    }

    @objc func stepperChanged(_ sender: GMStepper) {
        delegate?.stepperChanged(to: Int(sender.value))
    }
}
