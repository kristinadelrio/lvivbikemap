//
//  FeedbackController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit

class FeedbackController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TranslationConstants.kSendUsFeedback.localized
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
