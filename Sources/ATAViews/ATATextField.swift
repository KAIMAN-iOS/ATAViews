//
//  ATATextField.swift
//  taxi.Chauffeur
//
//  Created by GG on 05/02/2021.
//

import UIKit
import TextFieldEffects
import SnapKit


public protocol FieldConfigurable {
    var keyboardType: UIKeyboardType { get }
    func checkValidity()
    func validityString() -> String?
}

public protocol FieldTypable {
    associatedtype FieldType: FieldConfigurable
    var field: FieldType! { get }
}

public class FieldTextField<FormType: FieldConfigurable>: AkiraTextField, FieldTypable {
    public typealias FieldType = FormType
    public var field: FormType!
    var shouldCheckValidity: Bool = true
    public var isValid: Bool = false
    public func checkValidity() { isValid = true }
    public func validityString() -> String? { nil }
}

public class ATAFormTextField<FormType: FieldConfigurable>: ATATextField {
    private var _textfield: FieldTextField<FormType> = FieldTextField<FormType>()
    override private(set) public var textField: AkiraTextField! {
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
    public var placeholderColor: UIColor?
    public var textColor: UIColor?
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
    
    private(set) public var textField: AkiraTextField!
    func loadTextField() {
        textField = AkiraTextField()
        layoutTextField()
    }
    
    func layoutTextField() {
        textField.textColor = textColor ?? ATATextField.textColor
        textField.placeholderColor = placeholderColor ?? ATATextField.placeholderColor
        textField.backgroundColor = .white
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .horizontal)
        textField.font = .applicationFont(forTextStyle: .callout)
        textField.placeholderColor = placeholderColor ?? ATATextField.placeholderColor
        textField.borderColor = placeholderColor ?? ATATextField.placeholderColor
        textField.borderSize = (active: 0.4, inactive: 0.5)
        textField.rightViewMode = .whileEditing
        textField.placeholderInsets = CGPoint(x: 6, y: 10)
        textField.placeholderOffset = CGPoint(x: 0, y: -6)
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
