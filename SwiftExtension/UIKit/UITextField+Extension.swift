//
//  UITextField+Extension.swift
//  SmartBookingIOS
//
//  Created by dun on 2019/1/18.
//  Copyright © 2019 Duntech. All rights reserved.
//

import UIKit


extension UITextField {
    
    
    func setMaxLimit(_ limit: Int, errorMessage error: String? = nil) {
        self.maxLimit = limit
        self.errorMessage = error
        addTarget(HYInputProtocol.shared, action: HYInputProtocol.shared.textFieldSelector, for: .editingChanged)
    }
    
    private struct RuntimeKey {
        static let maxLimitKey = UnsafeRawPointer.init(bitPattern: "maxLimitKey".hashValue)
        static let errorMessageKey = UnsafeRawPointer.init(bitPattern: "errorMessageKey".hashValue)
    }
    
    internal var maxLimit: Int {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.maxLimitKey!) as! Int
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.maxLimitKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    internal var errorMessage: String? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.errorMessageKey!) as? String
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.errorMessageKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func inputToFitDecimalPad(_ string: String) -> Bool {
        guard keyboardType == .decimalPad else {
            return true
        }
        guard string != "" else {
            return true
        }
        if text == "0" && string != "." {
            text = ""
        }
        else if (text == nil || text! == "") && string == "." {
            text = "0"
        }
        else {
            guard let text = text else {
                return true
            }
            guard let index = text.index(of: ".") else {
                return true
            }
            let subString = text[index ..< text.endIndex]
            guard subString.count < 3 else {
                return false
            }
        }
        return true
    }
}

extension UITextView {
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    func setMaxLimit(_ limit: Int, errorMessage: String? = nil) {
        self.maxLimit = limit
        self.errorMessage = errorMessage
//        self.delegate = HYInputProtocol.shared
    }
    
    private struct RuntimeKey {
        static let maxLimitKey = UnsafeRawPointer(bitPattern: "maxLimitKey".hashValue)
        static let errorMessageKey = UnsafeRawPointer(bitPattern: "errorMessageKey".hashValue)
        static let placeholderLabelKey = UnsafeRawPointer(bitPattern: "placeholderLabelKey".hashValue)
        static let hy_delegateKey = UnsafeRawPointer(bitPattern: "hy_delegateKey".hashValue)
    }
    
    weak var hy_delegate: UITextViewDelegate? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.hy_delegateKey!) as? UITextViewDelegate
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.hy_delegateKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    internal var maxLimit: Int {
        get {
            let temp = objc_getAssociatedObject(self, RuntimeKey.maxLimitKey!)
            if temp == nil {
                return 0
            }
            return temp as! Int
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.maxLimitKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    internal var errorMessage: String? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.errorMessageKey!) as? String
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.errorMessageKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    fileprivate func textDidChanged() {
        
        if placeholder != nil {
            placeholderLabel?.isHidden = (text.lengthOfBytes(using: .utf8) != 0)
        }
        
        guard maxLimit > 0 else {
            return
        }
        let language = textInputMode?.primaryLanguage
        if language == "zh-Hans"  {
            if markedTextRange == nil && (text?.count)! > maxLimit {
                let index = text!.index(text!.startIndex, offsetBy: maxLimit)
                text = String(text![..<index])
                if errorMessage != nil {
                    
                     KeyWindow?.showError(errorMessage!)
                }
            }
        }
        else {
            if text!.count > maxLimit {
                let index = text!.index(text!.startIndex, offsetBy: maxLimit)
                text = String(text![..<index])
                if errorMessage != nil {
                    KeyWindow?.showError(errorMessage!)
                }
            }
        }
    }
    
    internal var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.placeholderLabelKey!) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.placeholderLabelKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var placeholder: String? {
        get {
            return placeholderLabel?.text
        }
        set {
            if placeholderLabel == nil {
                placeholderLabel = UILabel()
                placeholderLabel?.numberOfLines = 0
                placeholderLabel?.text = newValue
                placeholderLabel?.font = font
                placeholderLabel?.tag = 100
                if maxLimit == 0 {
//                    self.delegate = HYInputProtocol.shared
                }
                placeholderLabel?.sizeToFit()
                placeholderLabel?.textColor = UIColor.lightGray
                self.delegate = self
                addSubview(placeholderLabel!)
            }
        }
    }
    
    private func resizePlaceholder() {
        
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    func clearText() {
        text = ""
        if placeholder != nil {
            placeholderLabel?.isHidden = false
        }
    }
    
}

fileprivate class HYInputProtocol: NSObject {
    
    static let shared = HYInputProtocol()
}

extension HYInputProtocol {
    
    @objc func textFieldTextDidChanged(_ textfield: UITextField) {
        setInputLimit(for: textfield)
    }
    
    func setInputLimit(for textField: UITextField) {
        
        let length = textField.maxLimit
        let error = textField.errorMessage
        let language = textField.textInputMode?.primaryLanguage
        let text = textField.text
        if language == "zh-Hans"  {
            if textField.markedTextRange == nil && text!.count > length {
                let index = text!.index(text!.startIndex, offsetBy: length)
                textField.text = String(text![..<index])
                if error != nil {
                    KeyWindow?.showError(error!)
                }
            }
        }
        else {
            if text!.count > length {
                let index = text!.index(text!.startIndex, offsetBy: length)
                textField.text = String(text![..<index])
                if error != nil {
                     KeyWindow?.showError(error!)
                }
            }
        }
    }
    
    var textFieldSelector: Selector {
        return #selector(textFieldTextDidChanged(_:))
    }
}

extension UITextView : UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        
        if placeholder != nil {
            placeholderLabel?.isHidden = (text.lengthOfBytes(using: .utf8) != 0)
        }
    }
}

extension HYInputProtocol: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.textDidChanged()
        textView.hy_delegate?.textViewDidChange!(textView)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard textView.returnKeyType == .done else {
            return textView.hy_delegate?.textView?(textView, shouldChangeTextIn: range,replacementText: text) ?? true
        }
        guard text == "\n" else {
            return textView.hy_delegate?.textView?(textView, shouldChangeTextIn: range,replacementText: text) ?? true
        }
        textView.endEditing(true)
        return false
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return textView.hy_delegate?.textViewShouldBeginEditing?(textView) ?? true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.hy_delegate?.textViewDidBeginEditing?(textView)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return textView.hy_delegate?.textViewShouldEndEditing?(textView) ?? true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.hy_delegate?.textViewDidEndEditing?(textView)
    }
}


