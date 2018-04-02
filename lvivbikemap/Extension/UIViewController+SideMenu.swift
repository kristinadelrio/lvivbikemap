//
//  File.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//


import UIKit

extension UIViewController {
    
    public var sideMenu: SideMenu? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SideMenu {
                return viewController as? SideMenu
            }
            viewController = viewController?.parent
        }
        return nil
    }
}

