//
//  Views.swift
//  Punch In
//
//  Created by Kyle Stewart on 3/16/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func getAddJobView(to contentView: UIView, for delegateView: UITextFieldDelegate) -> UIView {
        
        let jobInfoView = UIView(frame: CGRect(x: 30, y: 100, width: contentView.frame.width - 60, height: 300))
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .right
        nameLabel.attributedText = NSAttributedString(string: "JOB NAME", attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont])
        nameLabel.frame = CGRect(x: 0, y: 5, width: (jobInfoView.frame.width - 60) / 2, height: 30)
        
        let hourlyRateLabel = UILabel()
        hourlyRateLabel.textAlignment = .right
        hourlyRateLabel.attributedText = NSAttributedString(string: "HOURLY RATE", attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont])
        hourlyRateLabel.frame = CGRect(x: 0, y: 85, width: (jobInfoView.frame.width - 60) / 2, height: 30)
        
        // NAME TEXT FIELD
        let jobNameTextField = UITextField()
        jobNameTextField.backgroundColor = UIColor.clear
        jobNameTextField.layer.cornerRadius = 10
        jobNameTextField.layer.borderWidth = 0.5
        jobNameTextField.layer.borderColor = Styles.signInPageColorFont.cgColor
        jobNameTextField.tintColor = .white
        jobNameTextField.frame = CGRect(x: jobInfoView.frame.width / 2, y: 0, width: jobInfoView.frame.width / 2, height: 40)
        jobNameTextField.textColor = Styles.signInPageColorFont
        jobNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        jobNameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        jobNameTextField.delegate = delegateView
        
        // HOURLY RATE TEXT FIELD
        let hourlyRateTextField = UITextField()
        hourlyRateTextField.backgroundColor = UIColor.clear
        hourlyRateTextField.layer.cornerRadius = 10
        hourlyRateTextField.layer.borderWidth = 0.5
        hourlyRateTextField.layer.borderColor = Styles.signInPageColorFont.cgColor
        hourlyRateTextField.tintColor = Styles.signInPageColorFont
        hourlyRateTextField.frame = CGRect(x: jobInfoView.frame.width / 2, y: 80, width: jobInfoView.frame.width / 2, height: 40)
        hourlyRateTextField.textColor = Styles.signInPageColorFont
        hourlyRateTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        hourlyRateTextField.keyboardType = .decimalPad
        hourlyRateTextField.delegate = delegateView
        
        jobInfoView.addSubview(nameLabel)
        jobInfoView.addSubview(jobNameTextField)
        jobInfoView.addSubview(hourlyRateLabel)
        jobInfoView.addSubview(hourlyRateTextField)
        
        return jobInfoView
    }
    
}
