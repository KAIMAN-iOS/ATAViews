//
//  File.swift
//  
//
//  Created by GG on 11/02/2021.
//

import UIKit

@IBDesignable
public class SelectableButton: UIButton {
    public static var selectedColor: UIColor = .black
    public static var unselectedColor: UIColor = .white
    
    @IBInspectable
    public var selectedColor: UIColor?
    
    @IBInspectable
    public var unselectedColor: UIColor?
    
    @IBInspectable
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)  {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var buttonCornerRadius: CGFloat = 10.0  {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 1.0  {
        didSet {
            setNeedsLayout()
        }
    }
    public override var isSelected: Bool  {
        didSet {
            hasFocus = isSelected
        }
    }
    var hasFocus: Bool = false
    var focusColor: UIColor { hasFocus ? (selectedColor ?? SelectableButton.selectedColor) : (unselectedColor ?? SelectableButton.unselectedColor) }
    var unfocusedColor: UIColor { hasFocus == false ? (selectedColor ?? SelectableButton.selectedColor) : (unselectedColor ?? SelectableButton.unselectedColor) }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = borderWidth
        layer.borderColor = (selectedColor ?? SelectableButton.selectedColor).cgColor
        backgroundColor = focusColor
        setTitleColor(unfocusedColor, for: .normal)
        layer.cornerRadius = buttonCornerRadius
        contentEdgeInsets = contentInsets
    }
}
