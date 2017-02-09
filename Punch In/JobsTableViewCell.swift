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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
