//
//  SideMenuController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
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
    private var filters = FiltersMediator.filters
    private var isFiltering = false
    private var isCompileRoad = false
    
    private var skeleton: [Row] {
        return [.addMarker, .buildRoad, .filter, .bikeRental, .bikeSharing, .bikeRepair,
                .bikeStops, .interestPlaces, .bicyclePaths, .bikeParking, .events,
                .news, .feedback, .about]
    }
}

extension SideMenuController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch skeleton[indexPath.row] {
        case .compileRoad:
            return isCompileRoad ? 80.0 : 0.0
        case .bikeRental, .bikeSharing, .bikeRepair,
             .bikeStops, .interestPlaces, .bicyclePaths, .bikeParking:
            return isFiltering ? 44.0 : 0.0
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
            FiltersMediator.update(filter: .bikeRental, value: !filters.bikeRental)
        case .bikeSharing:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeSharing
            FiltersMediator.update(filter: .bikeSharing, value: !filters.bikeSharing)
        case .bikeRepair:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeRepair
            FiltersMediator.update(filter: .bikeRepair, value: !filters.bikeRepair)
        case .bikeStops:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeStops
            FiltersMediator.update(filter: .bikeStops, value: !filters.bikeStops)
        case .interestPlaces:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.interestPlaces
            FiltersMediator.update(filter: .interestPlaces, value: !filters.interestPlaces)
        case .bicyclePaths:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bicyclePaths
            FiltersMediator.update(filter: .bicyclePaths, value: !filters.bicyclePaths)
        case .bikeParking:
            (tableView.cellForRow(at: indexPath) as? FilterCell)?.isChecked = !filters.bikeParking
            FiltersMediator.update(filter: .bikeParking, value: !filters.bikeParking)
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
            cell.configure(with: TranslationConstants.kAddNewMarker.localized, #imageLiteral(resourceName: "add"))
            return cell
        case .buildRoad:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBuildNewRoad.localized, #imageLiteral(resourceName: "ic_timeline"))
            return cell
        case .events:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kEvents.localized, #imageLiteral(resourceName: "ic_event"))
            return cell
        case .feedback:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kSendUsFeedback.localized, #imageLiteral(resourceName: "ic_feedback"))
            return cell
        case .filter:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kFilter.localized, #imageLiteral(resourceName: "ic_filter_list"))
            return cell
        case .news:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kNewsFeed.localized, #imageLiteral(resourceName: "ic_dashboard"))
            return cell
        case .about:
            let cell: SideMenuCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kAboutUs.localized, #imageLiteral(resourceName: "ic_info"))
            return cell
        case .bikeRental:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikeRental.localized, state: filters.bikeRental)
            return cell
        case .bikeSharing:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikeSharing.localized, state: filters.bikeSharing)
            return cell
        case .bikeRepair:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikeRepair.localized, state: filters.bikeRepair)
            return cell
        case .bikeStops:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikeStops.localized, state: filters.bikeStops)
            return cell
        case .interestPlaces:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikeInterests.localized, state: filters.interestPlaces)
            return cell
        case .bicyclePaths:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikePath.localized, state: filters.bicyclePaths)
            return cell
        case .bikeParking:
            let cell: FilterCell = tableView.dequeueReusableCell(at: indexPath)
            cell.configure(with: TranslationConstants.kBikeParking.localized, state: filters.bikeParking)
            return cell
        case .compileRoad:
            let cell: RoadCell = tableView.dequeueReusableCell(at: indexPath)
            return cell
        }
    }
}


