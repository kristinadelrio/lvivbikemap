//
//  ThemeScheme.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

class ThemeScheme {

    static var selectedColor: UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    static var unselectedColor: UIColor {
        return .clear
    }
    
    static var borderColor: UIColor {
        return UIColor.gray.withAlphaComponent(0.75)
    }
    
    static var clasterColors: [UIColor] {
        return [UIColor(hex: 0x88CC88), UIColor(hex: 0x55AA55), UIColor(hex: 0x116611), UIColor(hex: 0x004400), UIColor(hex: 0x001F00)]
    }
}
