//
//  UIColor.swift
//  Uniq
//
//  Created by Steven Gusev on 05/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        let red: Int = (rgb >> 16) & 0xFF
        let green: Int = (rgb >> 8) & 0xFF
        let blue: Int = rgb & 0xFF
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
