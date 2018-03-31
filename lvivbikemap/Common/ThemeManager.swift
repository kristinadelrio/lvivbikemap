//
//  ColorTheme.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

class ThemeManager {

    static var shared = ThemeManager()
    
    var selectedColor: UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    var unselectedColor: UIColor {
        return .clear
    }
}
