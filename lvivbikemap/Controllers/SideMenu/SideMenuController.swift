//
//  SideMenuController.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    
    @IBOutlet weak var controllersTableView: UITableView!
    
    enum Row: Int {
        case addMarker
        case buildRoad
        case filter
        case events
        case news
        case feedback
        case about
    }
    
    var skeleton: [Row] = [.addMarker, .buildRoad, .filter, .events, .news, .feedback, .about]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        controllersTableView.selectRow(at: IndexPath(row: 0, section: 0),
                                       animated: true, scrollPosition: .top)
        
    }
}

extension SideMenuController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch skeleton[indexPath.row] {
        case .addMarker: print("Present")
        case .buildRoad: print("Present")
        case .events: print("Present")
        case .feedback: print("Present")
        case .filter: print("Present")
        case .news: print("Present")
        case .about:
            
            if let controller = storyboard?.instantiateViewController(
                withIdentifier: "AboutController") {
                sideMenuController()?.closeSideMenu()
                sideMenuController()?.mainViewController?.present(controller, animated: true, completion: nil)
                
                
            }
        }
    }
    
    
    //
    func changeViewController() {
        
    }
}

extension SideMenuController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skeleton.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "sideMenuCell", for: indexPath) as? SideMenuCell else {
                return UITableViewCell()
        }
        
        switch skeleton[indexPath.row] {
        case .addMarker: cell.configure(with: "Add new marker".localized)
        case .buildRoad: cell.configure(with: "Build new road".localized)
        case .events: cell.configure(with: "Events".localized)
        case .feedback: cell.configure(with: "Send us feedback".localized)
        case .filter: cell.configure(with: "Filter".localized)
        case .news: cell.configure(with: "News feed".localized)
        case .about: cell.configure(with: "About us".localized)
        }
        
        return cell
    }
}


