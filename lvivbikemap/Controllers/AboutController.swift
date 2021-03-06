//
//  AboutController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit
import SafariServices
import MessageUI

class AboutController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    enum Row: Int {
        case facebook
        case mail
    }
    
    private var skeleton: [Row] = [.facebook, .mail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        navBar.topItem?.title = "About us".localized
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AboutController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch skeleton[indexPath.row] {
        case .facebook:
            let cell: UITableViewCell = tableView.dequeueReusableCell(at: indexPath)
            cell.imageView?.image = #imageLiteral(resourceName: "facebook")
            cell.textLabel?.text = "Our page in Facebook".localized
            return cell
        case .mail:
            let cell: UITableViewCell = tableView.dequeueReusableCell(at: indexPath)
            cell.imageView?.image = #imageLiteral(resourceName: "gmail")
            cell.textLabel?.text = "Mail us".localized
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skeleton.count
    }
}

extension AboutController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch skeleton[indexPath.row] {
        case .facebook:
            guard let url = URL(string: "https://www.facebook.com/comfycity.lviv/") else {
                return
            }
            
            let safari = SFSafariViewController(url: url)
            safari.dismissButtonStyle = .close
            self.present(safari, animated: true, completion: nil)
            
        case .mail:
            if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            }
            sendEmail()
        }
    }
}

extension AboutController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["comfycity@ukr.net"])
        composeVC.setSubject("Hello, Lviv Bike Map!".localized)
        composeVC.setMessageBody("This is my message body!".localized, isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
