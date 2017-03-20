//
//  UIViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 3/19/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Manage Keyboard, let the user exit
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
