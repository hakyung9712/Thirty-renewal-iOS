//
//  UITextField+Extension.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/27.
//

import UIKit

@IBDesignable extension UITextField {
    @IBInspectable var setLeftPadding: Bool {
        set {
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
            self.leftViewMode = .always
        }
        get {
            return true
        }
    }
}
