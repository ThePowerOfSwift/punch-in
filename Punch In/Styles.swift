//
//  Styles.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/13/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation
import UIKit

class Styles {
    
    static var signInPageColorFont: UIColor = UIColor.white
    
    static var standardFont = UIFont(name: "Ubuntu", size: 20)
        
    static let loginBackgroundVideoURL = Bundle.main.url(forResource: "snow", withExtension: "mp4")
    
}

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return rgba(r: r, g: g, b: b, a: 1)
    }
    
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255   , green: g / 255, blue: b / 255, alpha: a)
    }
    
    open class var mainColor: UIColor {
        return rgb(r: 104, g: 102, b: 104)
    }
    
    open class var secondaryColor: UIColor {
        return rgb(r: 191, g: 191, b: 191)
    }
    
    open class var thirdColor: UIColor {
        return rgb(r: 216, g: 216, b: 216)
    }
}

class chevron {
    
    static let left = UIImage(cgImage: #imageLiteral(resourceName: "left_chevron").cgImage!)
    static let down = UIImage(cgImage: #imageLiteral(resourceName: "left_chevron").cgImage!, scale: 1.0, orientation: .leftMirrored)
    static let right = UIImage(cgImage: #imageLiteral(resourceName: "left_chevron").cgImage!, scale: 1.0, orientation: .down)
    static let up = UIImage(cgImage: #imageLiteral(resourceName: "left_chevron").cgImage!, scale: 1.0, orientation: .right)
    
}


