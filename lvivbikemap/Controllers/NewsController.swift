//
//  NewsController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit
import WebKit

class NewsController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
