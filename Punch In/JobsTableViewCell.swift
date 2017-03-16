//
//  JobsTableViewCell.swift
//  Punch In
//
//  Created by Kyle Stewart on 2/1/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var hoursWorkedLabel: UILabel!
    @IBOutlet weak var barGraphView: BarGraphView!
    @IBOutlet weak var clockInButton: UIButton!
    @IBOutlet weak var dollarsEarnedLabel: UILabel!
    @IBOutlet weak var barGraphViewHeightConstraint: NSLayoutConstraint!
    
    func collapse() {
        barGraphView.isHidden = true
        clockInButton.isHidden = true
        dollarsEarnedLabel.isHidden = true
    }
    
    func extend() {
        barGraphView.isHidden = false
        clockInButton.isHidden = false
        dollarsEarnedLabel.isHidden = false
        //let barGraphViewHeight = barGraphViewHeightConstraint.constant
        //barGraphViewHeightConstraint.constant = 0
        layoutIfNeeded()
        
        UIView.animate(withDuration: 3.3) {
            //self.barGraphViewHeightConstraint.constant = barGraphViewHeight
            self.layoutIfNeeded()
            
            
        }
        
    }
    
    
}
