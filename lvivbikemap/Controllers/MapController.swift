//
//  MapController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit
import GoogleMaps
import RealmSwift
import CoreLocation

class MapController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIButton!
    
    private var clusterManager: GMUClusterManager!
    private var filtersToken: NotificationToken?
    
    let manager = CLLocationManager()
    var points: [Point]? = nil {
        didSet {
            let iconGenerator = GMUDefaultClusterIconGenerator()
            let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
            let renderer = GMUDefaultClusterRenderer(
                mapView: mapView, clusterIconGenerator: iconGenerator)
            clusterManager = GMUClusterManager(
                map: mapView, algorithm: algorithm, renderer: renderer)
            filtered = points
            
        }
    }
    
    var filtered: [Point]? = nil {
        didSet {
            clusterManager.clearItems()
            clusterize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        requestUserLocation()
        configureService()
        loadPoint()
    }
    
    /// Show side menu on tap
    @IBAction func showMenu(_ sender: Any) {
        toggle()
    }
    
    /// Loads velo points
    private func loadPoint() {
        MapService.shared.getPoints { [weak self] (err, points) in
            self?.points = points
        }
    }
    
    /// Puts markers on the map in cluster
    private func clusterize() {
        generateMarkers()
        clusterManager.cluster()
    }
    
    /// Adds places markers on the map
    private func generateMarkers() {
        DispatchQueue.main.async {
            self.filtered?.forEach({
                let lat = $0.feature?.geametry?.coordinate[1] ?? 0
                let long = $0.feature?.geametry?.coordinate[0] ?? 0
                let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let name = $0.feature?.properties?.name ?? ""
                let item = ClusterPoint(position: position, name: name)
                self.clusterManager.add(item)
            })
        }
    }
    
    /// Requests user location
    private func requestUserLocation() {
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

extension MapController {

    func toggle() {
        sideMenu?.toggleSideMenu()
    }
    
    func open() {
        sideMenu?.openSideMenu()
    }
    
    func close() {
        sideMenu?.closeSideMenu()
    }
}

extension MapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let lat = location?.coordinate.latitude ?? 0.0
        let long = location?.coordinate.longitude ?? 0.0
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
        changeLocationStatus()
        mapView.animate(to: camera)
        self.manager.stopUpdatingLocation()
    }
    
    func changeLocationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.isMyLocationEnabled = true
        default:
            mapView.isMyLocationEnabled = false
        }
    }
}

enum Category: String {
    case sharing = "5abfa2fcf6c9d8220a99a9f9"
    case repair = "5abfa2fcf6c9d8220a99a9fa"
    case rental = "5abfa2fcf6c9d8220a99a9f8" // and store
    case parking = "5abfa2fcf6c9d8220a99a9fe"
    case path = "5abfa2fcf6c9d8220a99a9fd"
    case stops = "5abfa2fcf6c9d8220a99a9fb"
    case interests = "5abfa2fcf6c9d8220a99a9fc"
}

extension MapController {
    
    func configureService() {
        filtersToken = FiltersProvider.filters().observe(updateValues(_:))
    }
    
    func updateValues(_ change: ObjectChange) {
        switch change {
        case .change(let properties):
            print("Need to filter: \(properties)")
        default:
            break
        }
    }
    
    func filter() {
        let filters = FiltersProvider.filters()
        var filteredPoints = points
        
        if !filters.bikeStops {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.stops.rawValue })
        }
        
        if !filters.bikeRental {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.rental.rawValue })
        }
        
        if !filters.bikeParking {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.parking.rawValue })
        }
        
        if !filters.bicyclePaths {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.path.rawValue })
        }
        
        if !filters.bikeSharing {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.sharing.rawValue })
        }
        
        if !filters.bikeRepair {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.repair.rawValue })
        }
        
        if !filters.interestPlaces {
            filteredPoints = filtered?.filter({ $0.categoryID ?? "" == Category.interests.rawValue })
        }
        
        filtered = filteredPoints
    }
}
