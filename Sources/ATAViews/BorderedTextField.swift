//
//  BorderedTextField.swift
//  taxi.Chauffeur
//
//  Created by GG on 15/01/2021.
//

import UIKit
import TextFieldExtension

protocol FieldTypeConfigurable {
    var configuration: FieldTypeConfiguration { get }
    var isMandatory: Bool { get }
}

enum FieldTypeConfiguration {
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

class BorderedTextField: UIView {
    static var boarderColor: UIColor = .gray
    var boarderColor: UIColor?
    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        layer.borderWidth = 1.0
        layer.borderColor = (boarderColor ?? BorderedTextField.boarderColor).cgColor
    }
        
    private(set) var field: FieldTypeConfigurable!
    func configure(_ field: FieldTypeConfigurable) {
        self.field = field
        textfield.keyboardType = field.configuration.keyboardType ?? .default
    }
}
