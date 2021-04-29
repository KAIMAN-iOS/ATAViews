//
//  File.swift
//  
//
//  Created by GG on 11/02/2021.
//

import UIKit

@IBDesignable
public class SelectableButton: UIButton {
    static public var selectedBackgroundColor: UIColor = .black
    static public var selectedTextColor: UIColor = .white
    static public var selectedBorderColor: UIColor = .black
    static public var unselectedBackgroundColor: UIColor = .clear
    static public var unselectedTextColor: UIColor = .gray
    static public var unselectedBorderColor: UIColor = .gray
    
    @IBInspectable public var selectedBackgroundColor: UIColor?
    @IBInspectable public var selectedTextColor: UIColor?
    @IBInspectable public var selectedBorderColor: UIColor?
    @IBInspectable public var unselectedBackgroundColor: UIColor?
    @IBInspectable public var unselectedTextColor: UIColor?
    @IBInspectable public var unselectedBorderColor: UIColor?
    
    @IBInspectable public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)  {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var buttonCornerRadius: CGFloat = 10.0  {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.5  {
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
    var componentBackgroundColor: UIColor { hasFocus ? (selectedBackgroundColor ?? SelectableButton.selectedBackgroundColor) : (unselectedBackgroundColor ?? SelectableButton.unselectedBackgroundColor) }
    var textColor: UIColor { hasFocus ? (selectedTextColor ?? SelectableButton.selectedTextColor) : (unselectedTextColor ?? SelectableButton.unselectedTextColor) }
    var borderColor: UIColor { hasFocus ? (selectedBorderColor ?? SelectableButton.selectedBorderColor) : (unselectedBorderColor ?? SelectableButton.unselectedBorderColor) }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        backgroundColor = componentBackgroundColor
        setTitleColor(textColor, for: .normal)
        layer.cornerRadius = buttonCornerRadius
        contentEdgeInsets = contentInsets
    }
}
