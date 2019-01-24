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
    
    enum Row: Int {
        case facebook
        case mail
    }
    
    private var skeleton: [Row] = [.facebook, .mail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        title = TranslationConstants.kAboutUs.localized
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AboutController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch skeleton[indexPath.row] {
        case .facebook:
            let cell: UITableViewCell = tableView.dequeueReusableCell(at: indexPath)
            cell.imageView?.image = #imageLiteral(resourceName: "facebook")
            cell.textLabel?.text = TranslationConstants.kOurFacebook.localized
            return cell
        case .mail:
            let cell: UITableViewCell = tableView.dequeueReusableCell(at: indexPath)
            cell.imageView?.image = #imageLiteral(resourceName: "gmail")
            cell.textLabel?.text = TranslationConstants.kMailUs.localized
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skeleton.count
    }
}

extension AboutController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch skeleton[indexPath.row] {
        case .facebook:
            guard let url = URL(string: ResourceStrings.kFacebookLink) else {
                return
            }
            
            let safari = SFSafariViewController(url: url)
            safari.dismissButtonStyle = .close
            self.present(safari, animated: true, completion: nil)
            
        case .mail:
            if !MFMailComposeViewController.canSendMail() {
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
        composeVC.setToRecipients([ResourceStrings.kEmailAdress])
        composeVC.setSubject(TranslationConstants.kEmailSubject.localized)
        composeVC.setMessageBody(TranslationConstants.kEmailBody.localized, isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
