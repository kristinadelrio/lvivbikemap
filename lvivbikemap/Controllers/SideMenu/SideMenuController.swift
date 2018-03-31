//
//  SideMenuController.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    enum Row: Int {
        case addMarker
        case buildRoad
        case filter
        case events
        case news
        case feedback
        case about

        case bikeRental
        case bikeSharing
        case bikeRepair
        case bikeStops
        case interestPlaces
        case bicyclePaths
        case bikeParking
    }
    
    var skeleton: [Row] = [.addMarker, .buildRoad, .filter, .events, .news, .feedback, .about]
    var filering: [Row] = [.addMarker, .buildRoad, .filter, .bikeRental,
                           .bikeSharing, .bikeRepair, .bikeStops, .interestPlaces, .bicyclePaths,
                           .bikeParking, .events, .news, .feedback, .about]

    var isFiltering: Bool = false
}

extension SideMenuController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch isFiltering ? filering[indexPath.row] : skeleton[indexPath.row] {
        case .addMarker: print("Present")
        case .buildRoad: print("Present")
        case .events: print("Present")
        case .feedback: print("Present")
        case .filter:
            isFiltering = !isFiltering
            tableView.reloadData()
        case .news: print("Present")
        case .about:
            if let controller = storyboard?.instantiateViewController(
                withIdentifier: "AboutController") {
                sideMenuController()?.closeSideMenu()
                sideMenuController()?.mainViewController?.present(
                    controller, animated: true, completion: nil)
            }
        default:
            break
        }
    }
}

extension SideMenuController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filering.count : skeleton.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch isFiltering ? filering[indexPath.row] : skeleton[indexPath.row] {
        case .addMarker:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Add new marker".localized, #imageLiteral(resourceName: "add"))
            return cell
        case .buildRoad:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Build new road".localized, #imageLiteral(resourceName: "ic_timeline"))
            return cell
        case .events:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Events".localized, #imageLiteral(resourceName: "ic_event"))
            return cell
        case .feedback:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Send us feedback".localized, #imageLiteral(resourceName: "ic_feedback"))
            return cell
        case .filter:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Filter".localized, #imageLiteral(resourceName: "ic_filter_list"))
            return cell
        case .news:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "News feed".localized, #imageLiteral(resourceName: "ic_dashboard"))
            return cell
        case .about:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "About us".localized, #imageLiteral(resourceName: "ic_info"))
            return cell
        case .bikeRental:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bike rental".localized, state: false)
            return cell
        case .bikeSharing:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Public bike sharing".localized, state: false)
            return cell
        case .bikeRepair:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bike repair".localized, state: false)
            return cell
        case .bikeStops:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Usefull stops".localized, state: false)
            return cell
        case .interestPlaces:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Place of interest".localized, state: false)
            return cell
        case .bicyclePaths:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bicycle path".localized, state: false)
            return cell
        case .bikeParking:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bike parking".localized, state: false)
            return cell
        }
    }
}


