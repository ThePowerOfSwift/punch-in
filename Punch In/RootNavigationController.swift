//
//  RootNavigationController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    fileprivate var mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    static weak var shared: RootNavigationController! {
        willSet {
            assert(newValue != nil && shared == nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RootNavigationController.shared = self
        loadInitialView()
    }

    func loadInitialView() {
//        if Network.authToken == "" {
            presentLogin(animated: false)
//        } else {
//            presentHome(animated: false)
//        }
    }
    
    func presentLogin(animated: Bool) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: Constants.viewControllers.login) as! LoginViewController
        setViewControllers([vc], animated: animated)
    }
    
    func presentHome(animated: Bool) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: Constants.viewControllers.jobsTable)
        setViewControllers([vc], animated: animated)
    }

}
