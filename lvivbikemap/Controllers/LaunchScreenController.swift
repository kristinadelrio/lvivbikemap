//
//  File.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    @IBOutlet weak var veloIcon: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    func prepare() {
        veloIcon.transform = CGAffineTransform(translationX: -view.frame.width, y: 0.0)
    }
    
    func animate() {
        UIView.animateKeyframes(withDuration: 4.0, delay: 0.0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
                self.veloIcon.transform = .identity
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 1.0, animations: {
                self.veloIcon.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0.0)
            })
            
        }) { _ in
            self.presentRootApplicationScene()
        }
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

