//
//  PINavigationViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class PINavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .mainColor
        navigationBar.isTranslucent = false
        navigationBar.barStyle = UIBarStyle.black
        navigationBar.tintColor = .white
        
    }


}
