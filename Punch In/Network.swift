//
//  Network.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation

class Network {
    
    public static let authTokenKey: String = "punchIn.authToken"
    
    public static var authToken: String {
        get {
            return UserDefaults.standard.string(forKey: authTokenKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: authTokenKey)
        }
    }
    
}
