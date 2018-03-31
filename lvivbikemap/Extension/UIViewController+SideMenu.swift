//
//  UIViewController+SideMenu.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func sideMenuController() -> SideMenu? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SideMenu {
                return viewController as? SideMenu
            }
            viewController = viewController?.parent
        }
        return nil
    }
    
    public func addMenuBarButtonItem() {
        let leftButton = UIBarButtonItem(title: "Menu".localized, style: .plain,
                                         target: self, action: #selector(toggle))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func toggle() {
        sideMenuController()?.toggleSideMenu()
    }
    
    func open() {
        sideMenuController()?.openSideMenu()
    }
    
    func close() {
        sideMenuController()?.closeSideMenu()
    }
}

