//
//  SignUpView.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/17/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpViewDelegate: class {
    
    func backToLogInButtonClicked()
    func completeSignUpButtonClicked()
    
}

class SignUpView: UIView, UITextFieldDelegate {
    
    var signUpView: UIView?
    var usernameLabel: UILabel?
    var passwordLabel: UILabel?
    var confirmPasswordLabel: UILabel?
    var usernameTextField: UITextField?
    var passwordTextField: UITextField?
    var confirmPasswordTextField: UITextField?
    var backToLoginButton: UIButton?
    var signUpButton: UIButton?
    
    weak var delegate: SignUpViewDelegate?
    
    var isOffScreen: Bool = true
    var isAnimatedUp: Bool = false
    
    func drawSignUpView(sender: LoginViewController) {
        
        // DEFINE SIGNUPVIEW - THE UIVIEW TO HOLD ALL
        signUpView = UIView(frame: CGRect(x: sender.view.frame.width + 15, y: sender.view.frame.minY + 35, width: sender.view.frame.width - 50, height: 370))
        
        // BACK TO LOGIN BUTTON - RETURN TO PREVIOUS, LOGIN SCREEN
        backToLoginButton = UIButton()
        backToLoginButton?.setImage(chevron.left, for: .normal)
        backToLoginButton?.tintColor = Styles().signInPageColorFont
        backToLoginButton?.frame = CGRect(x: 0, y: 0, width: 12.5, height: 21)
        backToLoginButton?.addTarget(self, action: #selector(backToLoginButtonClicked), for: .touchUpInside)
        
        // USERNAME LABEL
        usernameLabel = UILabel()
        usernameLabel?.textAlignment = .right
        usernameLabel?.attributedText = NSAttributedString(string: "USERNAME", attributes: [NSFontAttributeName: UIFont(name: (Styles().standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles().signInPageColorFont])
        usernameLabel?.frame = CGRect(x: 0, y: 80, width: (signUpView?.frame.width)! / 2, height: 20)
        
        // PASSWORD LABEL
        passwordLabel = UILabel()
        passwordLabel?.attributedText = NSAttributedString(string: "PASSWORD", attributes: [NSFontAttributeName: UIFont(name: (Styles().standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles().signInPageColorFont])
        passwordLabel?.textAlignment = .right
        passwordLabel?.frame = CGRect(x: 0, y: 160, width: (signUpView?.frame.width)! / 2, height: 20)
        
        // CONFIRM PASSWORD LABEL
        confirmPasswordLabel = UILabel()
        confirmPasswordLabel?.attributedText = NSAttributedString(string: "VERIFY PASSWORD", attributes: [NSFontAttributeName: UIFont(name: (Styles().standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles().signInPageColorFont])
        confirmPasswordLabel?.textAlignment = .right
        confirmPasswordLabel?.frame = CGRect(x: 0, y: 240, width: (signUpView?.frame.width)! / 2, height: 20)
        
        // USERNAME TEXT FIELD
        usernameTextField = UITextField()
        usernameTextField?.backgroundColor = UIColor.clear
        usernameTextField?.layer.cornerRadius = 10
        usernameTextField?.layer.borderWidth = 0.5
        usernameTextField?.layer.borderColor = Styles().signInPageColorFont.cgColor
        usernameTextField?.tintColor = Styles().signInPageColorFont
        usernameTextField?.frame = CGRect(x: (signUpView?.frame.width)! / 2 + 10, y: 75, width: (signUpView?.frame.width)! / 2 - 10, height: 30)
        usernameTextField?.textColor = Styles().signInPageColorFont
        usernameTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        usernameTextField?.autocapitalizationType = UITextAutocapitalizationType.none
        
        // PASSWORD TEXT FIELD
        passwordTextField = UITextField()
        passwordTextField?.backgroundColor = UIColor.clear
        passwordTextField?.layer.cornerRadius = 10
        passwordTextField?.layer.borderWidth = 0.5
        passwordTextField?.layer.borderColor = Styles().signInPageColorFont.cgColor
        passwordTextField?.tintColor = Styles().signInPageColorFont
        passwordTextField?.frame = CGRect(x: (signUpView?.frame.width)! / 2 + 10, y: 155, width: (signUpView?.frame.width)! / 2 - 10, height: 30)
        passwordTextField?.textColor = Styles().signInPageColorFont
        passwordTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        passwordTextField?.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField?.isSecureTextEntry = true
        passwordTextField!.delegate = sender
        
        // CONFIRM PASSWORD TEXT FIELD
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField?.backgroundColor = UIColor.clear
        confirmPasswordTextField?.layer.cornerRadius = 10
        confirmPasswordTextField?.layer.borderWidth = 0.5
        confirmPasswordTextField?.layer.borderColor = Styles().signInPageColorFont.cgColor
        confirmPasswordTextField?.tintColor = Styles().signInPageColorFont
        confirmPasswordTextField?.frame = CGRect(x: (signUpView?.frame.width)! / 2 + 10, y: 235, width: (signUpView?.frame.width)! / 2 - 10, height: 30)
        confirmPasswordTextField?.textColor = Styles().signInPageColorFont
        confirmPasswordTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        confirmPasswordTextField?.autocapitalizationType = UITextAutocapitalizationType.none
        confirmPasswordTextField?.isSecureTextEntry = true
        confirmPasswordTextField?.returnKeyType = UIReturnKeyType.go
        confirmPasswordTextField!.delegate = sender
        
        // SIGN UP BUTTON
        signUpButton = UIButton()
        signUpButton?.setAttributedTitle(NSAttributedString(string: "SIGN UP", attributes: [NSFontAttributeName: UIFont(name: (Styles().standardFont?.fontName)!, size: 20.0)!, NSForegroundColorAttributeName: Styles().signInPageColorFont]), for: .normal)
        signUpButton?.backgroundColor = UIColor.clear
        signUpButton?.layer.cornerRadius = 10
        signUpButton?.layer.borderWidth = 0.5
        signUpButton?.layer.borderColor = Styles().signInPageColorFont.cgColor
        signUpButton?.tintColor = Styles().signInPageColorFont
        signUpButton?.frame = CGRect(x: 20, y: 315, width: (signUpView?.frame.width)! - 40, height: 40)
        signUpButton?.addTarget(self, action: #selector(completeSignUpButtonClicked), for: .touchUpInside)
        
        
        // ADD TO SUBVIEW
        sender.view.addSubview(signUpView!)
        signUpView?.addSubview(usernameLabel!)
        signUpView?.addSubview(passwordLabel!)
        signUpView?.addSubview(confirmPasswordLabel!)
        signUpView?.addSubview(usernameTextField!)
        signUpView?.addSubview(passwordTextField!)
        signUpView?.addSubview(confirmPasswordTextField!)
        signUpView?.addSubview(signUpButton!)
        signUpView?.addSubview(backToLoginButton!)
        
    }
    
    func backToLoginButtonClicked() {
        delegate?.backToLogInButtonClicked()
        
    }
    
    func completeSignUpButtonClicked() {
        delegate?.completeSignUpButtonClicked()
    }
    
    func animateSignUpView(sender: LoginViewController) {
        
        UIView.animate(withDuration: 0.3) {
            var newX: CGFloat?
            if !self.isOffScreen {
                newX = sender.view.frame.width + CGFloat(30)
                self.isOffScreen = true
            } else {
                newX = sender.view.frame.minX + 30 
                self.isOffScreen = false
            }
            self.signUpView!.frame = CGRect(x: newX!, y: (self.signUpView?.frame.minY)!, width: (self.signUpView?.frame.width)!, height: (self.signUpView?.frame.height)!)
            
        }
        
    }
    
    func animateForKeyboard(sender: LoginViewController) {
        
        UIView.animate(withDuration: 0.3) {
            var newY: CGFloat?
            var newX: CGFloat?
            if !self.isAnimatedUp {
                newY = 0
                newX = 0
                self.isAnimatedUp = true
            } else {
                newY = sender.view.frame.width + 30
                newX = sender.view.frame.width + 30
            }
            self.signUpView!.frame = CGRect(x: newX!, y: newY!, width: (self.signUpView?.frame.width)!, height: (self.signUpView?.frame.height)!)
        }
        
    }
    
}
