//
//  EventsController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit

class EventsController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.topItem?.title = TranslationConstants.kEvents.localized
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
