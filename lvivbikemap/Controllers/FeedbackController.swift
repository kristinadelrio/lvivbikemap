//
//  FeedbackController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit

class FeedbackController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.topItem?.title = TranslationConstants.kSendUsFeedback.localized
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
