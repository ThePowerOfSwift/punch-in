//
//  PITableViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class PITableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.mainColor
    }

}
