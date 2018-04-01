//
//  UIViewController+SideMenu.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
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

