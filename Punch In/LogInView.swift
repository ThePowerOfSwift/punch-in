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
    
    func loginWithFacebook()
    func loginWithGoogle()
    func loginWithEmail(for email: String, with password: String)
    func signupWithFacebook()
    func signupWithGoogle()
    func signupWithEmail(for email: String, with password: String)
    func forgotPasswordButtonClicked()
    
}

class LogInView: UIView, UITextFieldDelegate {
    
    var userInputView: UIView!
    var views = [UIView]()
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var isLoginMode = true
    
    weak var delegate: LogInViewDelegate?
    var senderVC: LoginViewController!
    
    var isAnimatedUp: Bool = false
    
    func drawLogInView(sender: LoginViewController) {
        senderVC = sender
        
        var y: CGFloat = 0
        let padding: CGFloat = sender.view.frame.height / 10
        
        userInputView = UIView(frame: CGRect(x: 20, y: padding, width: sender.view.frame.width - 40, height: sender.view.frame.height - padding * 2))
        
        views.removeAll()
        
        views.append(getLabel(for: (isLoginMode ? "Login with" : "Sign up with"), at: CGRect(x: 0, y: 0, width: userInputView.frame.width, height: 40)))
        y = y + 40 + padding / 4
        
        views.append(getLargeButton(for: "Facebook", at: CGRect(x: 50, y: y, width: userInputView.frame.width - 100, height: 50), action: #selector(loginWithFacebook)))
        y = y + 50 + padding / 4
        
        views.append(getLargeButton(for: "Google", at: CGRect(x: 50, y: y, width: userInputView.frame.width - 100, height: 50), action: #selector(loginWithGoogle)))
        y = y + 50 + padding / 2
        
        views.append(getLabel(for: "or", at: CGRect(x: 0, y: y, width: userInputView.frame.width, height: 20)))
        y = y + 20 + padding / 2
        
        emailTextField = getTextField(for: "Email", at: CGRect(x: userInputView.frame.width / 2 - 120, y: y, width: 240, height: 40))
        views.append(emailTextField)
        y = y + 40 + padding / 4
        
        passwordTextField = getTextField(for: "Password", at: CGRect(x: userInputView.frame.width / 2 - 120, y: y, width: 240, height: 40))
        views.append(passwordTextField)
        y = y + 40 + padding / 2
        
        views.append(getLargeButton(for: (isLoginMode ? "Log In" : "Sign Up"), at: CGRect(x: 0, y: y,  width: userInputView.frame.width, height: 50), action: #selector(loginWithEmail)))
        y = y + 40 + padding / 2
        
        views.append(getSmallButton(for: "FORGOT PASSWORD", at: CGRect(x: 0, y: y, width: userInputView.frame.width / 2, height: 25), action: #selector(forgotPasswordButtonClicked)))
        
        views.append(getSmallButton(for: (isLoginMode ? "SIGN UP" : "LOG IN"), at: CGRect(x: userInputView.frame.width / 2, y: y, width: userInputView.frame.width / 2, height: 25), action: #selector(signUpButtonClicked)))
        
        userInputView.frame.size.height = y + 25
        userInputView.center = sender.view.center
        
        for view in views {
            
            if let textField = view as? UITextField {
                textField.delegate = sender
                userInputView.addSubview(textField)
            } else {
                userInputView.addSubview(view)
            }
            
        }
    
        sender.view.addSubview(userInputView)
        
    }
    
    func getLabel(for title: String, at frame: CGRect) -> UILabel {
        
        let label = UILabel(frame: frame)
        
        label.text = title
        label.font = Styles.standardFont?.withSize(18)
        label.textColor = Styles.signInPageColorFont
        label.textAlignment = .center
        
        return label
        
    }
    
    func getTextField(for placeholder: String, at frame: CGRect) -> UITextField {
        
        let textField = UITextField(frame: frame)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: Styles.signInPageColorFont.withAlphaComponent(0.6)])
        textField.backgroundColor = UIColor.clear
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = Styles.signInPageColorFont.cgColor
        textField.tintColor = Styles.signInPageColorFont
        textField.textColor = Styles.signInPageColorFont
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        
        if placeholder == "Password" {
            textField.isSecureTextEntry = true
            textField.returnKeyType = .go
        }
        
        return textField
    }
    
    func getSmallButton(for title: String, at frame: CGRect, action: Selector) -> UIButton {
        
        let button = UIButton(frame: frame)
        
        button.setAttributedTitle(NSAttributedString(
            string: title, attributes: [
            NSFontAttributeName: UIFont(name: Styles.standardFont!.fontName, size: 11.0)!,
            NSForegroundColorAttributeName: Styles.signInPageColorFont]), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
        
    }
    
    func getLargeButton(for title: String, at frame: CGRect, action: Selector) -> UIButton {
        
        // LARGE BUTTON: e.g., Facebook, Google, Log In
        let button = UIButton(frame: frame)
        button.setAttributedTitle(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont]), for: .normal)
        button.backgroundColor = UIColor.secondaryColor.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        //button.layer.borderWidth = 0.5
        //button.layer.borderColor = Styles.signInPageColorFont.cgColor
        button.tintColor = Styles.signInPageColorFont
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
        
    }
    
    func loginWithFacebook() {
        
        if isLoginMode {
            delegate?.loginWithFacebook()
        } else {
            delegate?.signupWithFacebook()
        }
        
    }
    
    func loginWithGoogle() {
        
        if isLoginMode {
            delegate?.loginWithGoogle()
        } else {
            delegate?.signupWithGoogle()
        }
        
    }
    
    func loginWithEmail() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else { return print("Need Email or password") }
        
        if isLoginMode {
            delegate?.loginWithEmail(for: email, with: password)
        } else {
            delegate?.signupWithEmail(for: email, with: password)
        }
        
    }
    
    func removeSubviews() {
        
        if userInputView != nil {
            for view in userInputView.subviews {
                view.removeFromSuperview()
            }
        }
        
    }
    
    func signUpButtonClicked() {
        isLoginMode = !isLoginMode
        removeSubviews()
        drawLogInView(sender: senderVC)
    }
    
    func forgotPasswordButtonClicked() {
        delegate?.forgotPasswordButtonClicked()
    }
    
    func animateForKeyboard(sender: LoginViewController) {
        
        UIView.animate(withDuration: 0.3) {
            var newY: CGFloat
            if !self.isAnimatedUp {
                newY = (self.userInputView.frame.origin.y) - 250
                self.isAnimatedUp = true
            } else {
                newY = (self.userInputView.frame.origin.y) + 250
                self.isAnimatedUp = false
            }
            self.userInputView.frame = CGRect(x: (self.userInputView.frame.origin.x), y: newY, width: self.userInputView.frame.width, height: (self.userInputView.frame.height))
            
        }
        
    }
    
}
