//
//  SideMenuController.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    
    enum Row: Int {
        case addMarker
        case buildRoad
        case filter
        case events
        case news
        case feedback
        case about
        
        case compileRoad
        
        case bikeRental
        case bikeSharing
        case bikeRepair
        case bikeStops
        case interestPlaces
        case bicyclePaths
        case bikeParking
    }
    
    @IBOutlet weak var tableView: UITableView!
    private var filters = FiltersProvider.filters()
    private var isFiltering = false
    private var isCompileRoad = false
    
    
    private var skeleton: [Row] {
        if isFiltering {
            return [.addMarker, .buildRoad, .filter, .bikeRental, .bikeSharing, .bikeRepair,
                    .bikeStops, .interestPlaces, .bicyclePaths, .bikeParking, .events,
                    .news, .feedback, .about]
        } else if isCompileRoad {
            return [.addMarker, .buildRoad, .compileRoad, .filter, .events, .news, .feedback, .about]
        } else {
            return [.addMarker, .buildRoad, .filter, .events, .news, .feedback, .about]
        }
    }
}

extension SideMenuController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch skeleton[indexPath.row] {
        case .compileRoad:
            return 80.0
        default:
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch skeleton[indexPath.row] {
        case .addMarker:
            print("TODO")
        case .buildRoad:
            isFiltering = isCompileRoad && isFiltering
            isCompileRoad = !isCompileRoad
            tableView.reloadData()
        case .events:
            present(with: "EventsController")
        case .feedback:
            present(with: "FeedbackController")
        case .news:
            present(with: "NewsController")
        case .about:
            present(with: "AboutController")
        case .filter:
            isCompileRoad = isFiltering && isCompileRoad
            isFiltering = !isFiltering
            tableView.reloadData()
        case .bikeRental:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeRental
            FiltersProvider.update(filter: .bikeRental, value: !filters.bikeRental)
        case .bikeSharing:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeSharing
            FiltersProvider.update(filter: .bikeSharing, value: !filters.bikeSharing)
        case .bikeRepair:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeRepair
            FiltersProvider.update(filter: .bikeRepair, value: !filters.bikeRepair)
        case .bikeStops:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeStops
            FiltersProvider.update(filter: .bikeStops, value: !filters.bikeStops)
        case .interestPlaces:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.interestPlaces
            FiltersProvider.update(filter: .interestPlaces, value: !filters.interestPlaces)
        case .bicyclePaths:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bicyclePaths
            FiltersProvider.update(filter: .bicyclePaths, value: !filters.bicyclePaths)
        case .bikeParking:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeParking
            FiltersProvider.update(filter: .bikeParking, value: !filters.bikeParking)
        default:
            break
        }
    }
    
    private func present(with identifier: String) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: identifier) {
            sideMenu?.closeSideMenu()
            sideMenu?.mainVC?.present(controller, animated: true, completion: nil)
        }
    }
}

extension SideMenuController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skeleton.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch skeleton[indexPath.row] {
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
            cell.configure(with: "Bike rental".localized, state: filters.bikeRental)
            return cell
        case .bikeSharing:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Public bike sharing".localized, state: filters.bikeSharing)
            return cell
        case .bikeRepair:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bike repair".localized, state: filters.bikeRepair)
            return cell
        case .bikeStops:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Usefull stops".localized, state: filters.bikeStops)
            return cell
        case .interestPlaces:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Place of interest".localized, state: filters.interestPlaces)
            return cell
        case .bicyclePaths:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bicycle path".localized, state: filters.bicyclePaths)
            return cell
        case .bikeParking:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: "Bike parking".localized, state: filters.bikeParking)
            return cell
        case .compileRoad:
            let cell: RoadCell = tableView.dequeueReusableCell(at: indexPath)
            return cell
        }
    }
}


