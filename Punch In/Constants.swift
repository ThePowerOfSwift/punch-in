//
//  Constants.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    // View Controllers
    struct viewControllers {
        static let jobsTable = "JobsVC"
        static let login = "LoginVC"
    }
    
    // Navigation Controllers
    struct navControllers {
        static let root = "RootNC"
    }
    
    // Cell Identifiers
    struct cellID {
        static let addJob = "addJobCell"
        static let job = "jobsCell"
    }
    
    // Heights
    struct height {
        static let addJobCell: CGFloat = 65
        static let jobCell: CGFloat = 104
    }
    
}
