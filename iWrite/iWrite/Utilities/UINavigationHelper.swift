//
//  UINavigationHelper.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 24/4/21.
//

import UIKit

extension UIView {
    public func removeAllSubviewsAndRemoveFromSuperview() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }

        removeFromSuperview()
    }

    public func removeAllSubviews() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
}
extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
    let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}

extension UITextField {
    func addBottomBorder(){
       let border = CALayer()
            let borderWidth = CGFloat(2.0) // Border Width
            border.borderColor = UIColor.red.cgColor
            border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
            border.borderWidth = borderWidth
            self.borderStyle = UITextField.BorderStyle.none
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
    }
}


