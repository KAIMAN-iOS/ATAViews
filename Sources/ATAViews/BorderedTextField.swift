//
//  BorderedTextField.swift
//  taxi.Chauffeur
//
//  Created by GG on 15/01/2021.
//

import UIKit
import TextFieldExtension
import SnapKit

public protocol FieldTypeConfigurable {
    var configuration: FieldTypeConfiguration { get }
    var isMandatory: Bool { get }
}

public enum FieldTypeConfiguration {
    case date, number, text, email, password, phone, picker, decimal
    
    var keyboardType: UIKeyboardType? {
        switch self {
        case .date: return nil
        case .picker: return nil
        case .number: return .numberPad
        case .decimal: return .decimalPad
        case .phone: return .phonePad
        case .text: return .asciiCapable
        case .email: return .emailAddress
        case .password: return .asciiCapable
        }
    }
    
    func inputView(textField: UITextField, target: Any, selector: Selector, viewColor: UIColor = UIColor.lightGray) -> UIView? {
        switch self {
        case .date: return textField.setInputViewDatePicker(target: target, selector: selector, viewColor: viewColor)
            
        case .picker:
            let screenWidth = UIScreen.main.bounds.width
            let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
            textField.inputView = picker
            textField.addKeyboardControlView(with: viewColor, target: textField, buttonStyle: .body)
            return picker
            
        default: return nil
        }
    }
}

public class BorderedTextField: UIView {
    public static var borderColor: UIColor = .gray
    public var borderColor: UIColor?
    public lazy var textfield: UITextField = UITextField()
    
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
    
    func loadObjects() {
        backgroundColor = .clear
        layer.borderWidth = 1.0
        layer.borderColor = (borderColor ?? BorderedTextField.borderColor).cgColor
        addSubview(textfield)
        textfield.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.bottom.right.equalToSuperview().inset(8)
        }
    }
        
    private(set) var field: FieldTypeConfigurable!
    public func configure(_ field: FieldTypeConfigurable) {
        self.field = field
        textfield.keyboardType = field.configuration.keyboardType ?? .default
    }
}
