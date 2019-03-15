//
//  UIView+Extension.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/15/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import UIKit

import UIKit

extension UIView {
    
    // MARK: Rounded, Borderded
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
