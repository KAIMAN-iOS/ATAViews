//
//  ATATextField.swift
//  taxi.Chauffeur
//
//  Created by GG on 05/02/2021.
//

import UIKit
import TextFieldEffects
import SnapKit
import Ampersand
import UIViewExtension

public protocol FieldConfigurable {
    var keyboardType: UIKeyboardType { get }
    func checkValidity()
    func validityString() -> String?
}

public protocol FieldTypable {
    associatedtype FieldType: FieldConfigurable
    var field: FieldType! { get }
}

public class FieldTextField<FormType: FieldConfigurable>: HoshiTextField, FieldTypable {
    public var lineColor: UIColor = .gray
    public var invalidLineColor: UIColor = .red
    public typealias FieldType = FormType
    public var field: FormType!
    var shouldCheckValidity: Bool = true
    public var isValid: Bool = false  {
        didSet {
            borderActiveColor = isValid ? lineColor : invalidLineColor
            borderInactiveColor = isValid ? lineColor : invalidLineColor
        }
    }

    public func checkValidity() { isValid = true }
    public func validityString() -> String? { nil }
}

public class ATAFormTextField<FormType: FieldConfigurable>: ATATextField {
    private var _textfield: FieldTextField<FormType> = FieldTextField<FormType>()
    override private(set) public var textField: HoshiTextField! {
        get {
            _textfield
        }
        
        set {
            // n/a
        }
    }
    override func loadTextField() {
        textField = _textfield
        layoutTextField()
        _textfield.keyboardType = _textfield.field.keyboardType
    }
}

public class ATATextField: UIView {
    public static var placeholderColor: UIColor = .gray
    public static var textColor: UIColor = .black
    public static var lineColor: UIColor = .gray
    public static var invalidLineColor: UIColor = .black
    public var placeholderColor: UIColor?
    public var textColor: UIColor?
    public var lineColor: UIColor?
    public var invalidLineColor: UIColor?
    public override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private(set) public var textField: HoshiTextField!
    func loadTextField() {
        textField = HoshiTextField()
        layoutTextField()
    }
    
    func layoutTextField() {
        textField.textColor = ATATextField.textColor
        textField.placeholderColor = placeholderColor ?? ATATextField.placeholderColor
        textField.backgroundColor = .clear
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .horizontal)
        textField.font = .applicationFont(forTextStyle: .callout)
        textField.placeholderColor = placeholderColor ?? ATATextField.placeholderColor
        textField.borderActiveColor = placeholderColor ?? ATATextField.placeholderColor
        textField.borderInactiveColor = placeholderColor ?? ATATextField.placeholderColor
        textField.borderThickness = (active: 0.4, inactive: 0.5)
        textField.rightViewMode = .whileEditing
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .horizontal)
        textField.addKeyboardControlView(with: .lightGray, target: self, buttonStyle: .footnote)
//        textField.placeholderInsets = CGPoint(x: 6, y: 10)
//        textField.placeholderOffset = CGPoint(x: 0, y: -6)
    }
    
    private func initialize() {
        loadTextField()
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(70)
        }
    }
}
