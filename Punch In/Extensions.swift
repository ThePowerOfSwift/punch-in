//
//  Extensions.swift
//  Punch In
//
//  Created by Kyle Stewart on 2/19/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}
