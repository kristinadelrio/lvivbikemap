//
//  File.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentRootApplicationScene()
    }
    
    func presentRootApplicationScene() {
        let mainViewController = storyboard?.instantiateViewController(withIdentifier:
            "MapScene")
        let sideMenuController = storyboard?.instantiateViewController(withIdentifier:
            "SideMenuControllerIdentifier") as? SideMenuController
        
        if let rootController = mainViewController, let slideMenuController = sideMenuController {
            let sideMenu = SideMenu(with: rootController, and: slideMenuController)
            self.present(sideMenu, animated: true, completion: nil)
        }
    }
}

