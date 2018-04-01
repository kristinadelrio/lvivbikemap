//
//  NewsController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit
import WebKit

class NewsController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.topItem?.title = "News feed".localized
        configure()
    }
    
    func configure() {
        guard let url = URL(string: "http://lav.org.ua/category/novyny/") else {
            return
        }
        
        errorLabel.text = ""
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewsController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        errorLabel.text = error.localizedDescription
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
}

