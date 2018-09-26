//
//  UIValidatedTextField.swift
//  Mosaic Golf
//
//  Created by Hernan Paez on 14/06/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidAlphanumeric() -> Bool {
        let charSet = CharacterSet.alphanumerics.inverted
        
        guard self.rangeOfCharacter(from: charSet, options: .caseInsensitive) == nil else {
            return false
        }
        
        return true
    }
    
    func isValidName() -> Bool {
        let charSet0 = CharacterSet.letters
        let charSet1 = CharacterSet(charactersIn: " ")
        let charSet = charSet0.union(charSet1).inverted
        
        guard self.rangeOfCharacter(from: charSet, options: .caseInsensitive) == nil else {
            return false
        }
        
        return true
        
    }
    
    func isPhoneNumber() -> Bool {
        return self.components(separatedBy: .whitespaces).joined().hasOnlyNumbers()
    }
    
    func hasOnlyLetters() -> Bool {
        let charSet = CharacterSet.letters.inverted
        guard self.rangeOfCharacter(from: charSet, options: .caseInsensitive) == nil else {
            return false
        }
        return true
    }
    
    func hasOnlyNumbers() -> Bool {
        let charSet = CharacterSet(charactersIn: "0123456789").inverted
        guard self.rangeOfCharacter(from: charSet, options: .caseInsensitive) == nil else {
            return false
        }
        return true
    }
    
    
}

class UIValidatedTextField : UITextField {
    
    enum Validation {
        case none
        case email
        case name
        case alphanumeric
        case onlyLetters
        case onlyNumbers
        case phoneNumber
        case password
        
        func validate(_ string:String, trimResult:Bool, fieldDescription:String?) throws -> String {
            if string.isEmpty {
                throw APPError(message: "\(fieldDescription ?? "") Field is required")
            }
            
            switch self {
            case .none:
                return trimResult ? string.trimmingWhitespaces : string
                
            case .email:
                let email = string.trimmingWhitespaces
                guard email.isValidEmail == true else {
                    throw APPError(message: "Not a valid email")
                }
                return email
                
            case .name:
                let txt = trimResult ? string.trimmingWhitespaces : string
                guard txt.isValidName() else {
                    throw APPError(message: "\(fieldDescription ?? "") Field contains invalid characters")
                }
                return txt
                
                
            case .alphanumeric:
                let txt = trimResult ? string.trimmingWhitespaces : string
                guard txt.isValidAlphanumeric() else {
                    throw APPError(message: "\(fieldDescription ?? "") Field contains invalid characters")
                }
                return txt
                
            case .onlyLetters:
                let txt = trimResult ? string.trimmingWhitespaces : string
                guard txt.hasOnlyLetters() else {
                    throw APPError(message: "\(fieldDescription ?? "") Field contains invalid characters")
                }
                return txt
                
            case .onlyNumbers:
                let txt = trimResult ? string.trimmingWhitespaces : string
                guard txt.hasOnlyNumbers() else {
                    throw APPError(message: "\(fieldDescription ?? "") Field contains invalid characters")
                }
                return txt
            
            case .phoneNumber:
                let txt = trimResult ? string.trimmingWhitespaces : string
                guard txt.isPhoneNumber() else {
                    throw APPError(message: "\(fieldDescription ?? "") Field contains invalid characters")
                }
                return txt
            
            case .password:
                guard string.count >= 8 else {
                    throw APPError(message: "\(fieldDescription ?? "") Field must have at least 8 characters")
                }
                
                return string
            }
        }
    }
    
    var validation:Validation = .none
    @IBInspectable var optional:Bool = true
    @IBInspectable var trimResult:Bool = true
    
    @IBInspectable var errorColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
    @IBInspectable var correctColor = UIColor.white
    
    func validateOnEnd() {
        do {
            _ = try self.validatedText()
            self.backgroundColor = correctColor
        }
        catch let error {
            Logger.log(message: error.localizedDescription, tag: String(describing: self), priority: .error)
            self.backgroundColor = errorColor
        }
    }
    
    override func resignFirstResponder() -> Bool {
        validateOnEnd()
        return super.resignFirstResponder()
    }
    
    func validatedText() throws -> String {
        let text = self.text ?? ""
        if self.optional && text.isEmpty == true {
            return ""
        }
        
        return try validation.validate(text, trimResult: trimResult, fieldDescription: self.placeholder)
    }
}

@IBDesignable class ValidatedHighlightTextField: UIValidatedTextField {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    @IBInspectable var defaultColor:UIColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1)
    @IBInspectable var highlightedColor:UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var lineHeight:CGFloat = 2
    
    fileprivate var color:UIColor?
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            _leftView?.frame = CGRect(x: 0.0, y: 0.0, width: leftPadding, height: self.frame.height)
        }
    }
    private var _leftView: UIView? = UIView(frame: CGRect.zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftView = _leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: lineHeight))
        (color ?? defaultColor).setFill()
        rectanglePath.fill()
    }
    
    override func becomeFirstResponder() -> Bool {
        color = highlightedColor
        self.setNeedsDisplay()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        color = defaultColor
        self.setNeedsDisplay()
        
        return super.resignFirstResponder()
    }
    
    override func validateOnEnd() {
        do {
            _ = try self.validatedText()
            color = defaultColor
        }
        catch let error {
            Logger.log(message: error.localizedDescription, tag: String(describing: self), priority: .error)
            self.color = errorColor
        }
        
        self.setNeedsDisplay()

    }
}

