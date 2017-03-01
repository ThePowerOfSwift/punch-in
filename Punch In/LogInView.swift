//
//  LogInView.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/18/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation
import UIKit

protocol LogInViewDelegate: class {
    
    func signUpButtonClicked()
    func forgotPasswordButtonClicked()
    
}

class LogInView: UIView, UITextFieldDelegate {
    
    var userInputView: UIView?
    var usernameLabel: UILabel?
    var passwordLabel: UILabel?
    var usernameTextField: UITextField?
    var passwordTextField: UITextField?
    var forgotPasswordButton: UIButton?
    var signupButton: UIButton?
    
    weak var delegate: LogInViewDelegate?
    
    var isOffScreen: Bool = false
    var isAnimatedUp: Bool = false
    
    func drawLogInView(sender: LoginViewController) {
    
        userInputView = UIView(frame: CGRect(x: sender.view.frame.maxX - 250, y: sender.view.frame.maxY / 2, width: 230, height: 235))
        
        usernameLabel = UILabel()
        usernameLabel?.text = "USERNAME"
        usernameLabel?.font = Styles.standardFont
        usernameLabel?.textColor = Styles.signInPageColorFont
        usernameLabel?.frame = CGRect(x: 50, y: 10, width: 150, height: 20)
        
        passwordLabel = UILabel()
        passwordLabel?.text = "PASSWORD"
        passwordLabel?.font = Styles.standardFont
        passwordLabel?.textColor = Styles.signInPageColorFont
        passwordLabel?.frame = CGRect(x: 50, y: 115, width: 150, height: 20)
        
        usernameTextField = UITextField()
        usernameTextField?.backgroundColor = UIColor.clear
        usernameTextField?.layer.cornerRadius = 10
        usernameTextField?.layer.borderWidth = 0.5
        usernameTextField?.layer.borderColor = Styles.signInPageColorFont.cgColor
        usernameTextField?.tintColor = Styles.signInPageColorFont
        usernameTextField?.frame = CGRect(x: 0, y: 50, width: 230, height: 40)
        usernameTextField?.textColor = Styles.signInPageColorFont
        usernameTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        usernameTextField?.autocapitalizationType = UITextAutocapitalizationType.none
        usernameTextField?.delegate = sender
        
        passwordTextField = UITextField()
        passwordTextField?.backgroundColor = UIColor.clear
        passwordTextField?.layer.cornerRadius = 10
        passwordTextField?.layer.borderWidth = 0.5
        passwordTextField?.layer.borderColor = Styles.signInPageColorFont.cgColor
        passwordTextField?.tintColor = Styles.signInPageColorFont
        passwordTextField?.frame = CGRect(x: 0, y: 155, width: 230, height: 40)
        passwordTextField?.textColor = Styles.signInPageColorFont
        passwordTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        passwordTextField?.isSecureTextEntry = true
        passwordTextField?.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField?.returnKeyType = UIReturnKeyType.go
        passwordTextField!.delegate = sender
        
        forgotPasswordButton = UIButton()
        forgotPasswordButton?.setAttributedTitle(NSAttributedString(string: "FORGOT PASSWORD", attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 11.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont]), for: .normal)
        forgotPasswordButton?.frame = CGRect(x: 0, y: 210, width: 100, height: 25)
        forgotPasswordButton?.sizeToFit()
        forgotPasswordButton?.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        
        signupButton = UIButton()
        signupButton?.setAttributedTitle(NSAttributedString(string: "SIGN UP", attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 11.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont]), for: .normal)
        signupButton?.frame = CGRect(x: 150, y: 210, width: 100, height: 25)
        signupButton?.sizeToFit()
        signupButton?.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        sender.view.addSubview(userInputView!)
        userInputView?.addSubview(usernameLabel!)
        userInputView?.addSubview(usernameTextField!)
        userInputView?.addSubview(passwordLabel!)
        userInputView?.addSubview(passwordTextField!)
        userInputView?.addSubview(forgotPasswordButton!)
        userInputView?.addSubview(signupButton!)
    
    }
    
    func signUpButtonClicked() {
        delegate?.signUpButtonClicked()
    }
    
    func forgotPasswordButtonClicked() {
        delegate?.forgotPasswordButtonClicked()
    }
    
    func animateLogInView(sender: LoginViewController) {
        
        UIView.animate(withDuration: 0.3) {
            var newX: CGFloat?
            if !self.isOffScreen {
                newX = -250
                self.isOffScreen = true
            } else {
                newX = sender.view.frame.maxX - CGFloat(250)
                self.isOffScreen = false
            }
            self.userInputView!.frame = CGRect(x: newX!, y: (self.userInputView?.frame.minY)!, width: (self.userInputView?.frame.width)!, height: (self.userInputView?.frame.height)!)
        }

    }
    
    func animateForKeyboard(sender: LoginViewController) {
        
        UIView.animate(withDuration: 0.3) {
            var newY: CGFloat?
            if !self.isAnimatedUp {
                newY = (self.userInputView?.frame.origin.y)! - 250
                self.isAnimatedUp = true
            } else {
                newY = (self.userInputView?.frame.origin.y)! + 250
                self.isAnimatedUp = false
            }
            self.userInputView!.frame = CGRect(x: (self.userInputView?.frame.origin.x)!, y: newY!, width: (self.userInputView?.frame.width)!, height: (self.userInputView?.frame.height)!)
            
        }
        
    }
    
}
