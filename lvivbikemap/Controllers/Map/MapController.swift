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
    
    @IBOutlet var markerDetailView: MarkerDetailView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIButton!
    
    private var clusterManager: GMUClusterManager!
    private var filtersToken: NotificationToken?
    
    let manager = CLLocationManager()
    var points: [Point]? = nil {
        didSet {
            filter()
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
        
        initClasterization()
        manager.delegate = self
        changeLocationStatus(nil)
        requestUserLocation()
        configureService()
        setupMapStyle()
        loadPoint()
    }
    
    func initClasterization() {
        let iconGenerator = GMUDefaultClusterIconGenerator(
            buckets: [10, 25, 50, 100, 200], backgroundColors: ThemeManager.shared.clasterColors)
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    /// Set style for map loaded from json
    private func setupMapStyle() {
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
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
                
                let item = ClusterPoint(position: position,
                                        name: name,
                                        image: Category(rawValue: $0.categoryID ?? "")!.icon)
   
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

extension MapController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        markerDetailView.prepareForReuse()
        markerDetailView.imageView.image = #imageLiteral(resourceName: "cycling")
        markerDetailView.nameLabel.text = marker.title
        markerDetailView.loactionLabel.text = "\(marker.position.latitude)" + "|" + "\(marker.position.longitude)"
        return markerDetailView
    }
}

extension MapController: GMUClusterManagerDelegate {
    
    private func clusterManager(clusterManager: GMUClusterManager, didTapCluster cluster: GMUCluster) {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
    }

}

extension MapController: GMUClusterRendererDelegate {
    
    func renderer(_ renderer: GMUClusterRenderer, markerFor object: Any) -> GMSMarker? {
        if let obj = object as? ClusterPoint {
        let mark = GMSMarker(position: obj.position)
            mark.icon = obj.image
            mark.title = obj.name
            
            return mark
        }
        
        return nil
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
        changeLocationStatus(locations.last)
        self.manager.stopUpdatingLocation()
    }
    
    func changeLocationStatus(_ location: CLLocation?) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            let lat = location?.coordinate.latitude ?? 0.0
            let long = location?.coordinate.longitude ?? 0.0
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
            mapView.animate(to: camera)
            mapView.isMyLocationEnabled = true
        default:
            let camera = GMSCameraPosition.camera(withLatitude: 49.83826, longitude: 24.02324, zoom: 10.0)
            mapView.camera = camera
            mapView.isMyLocationEnabled = false
            mapView.animate(to: camera)
        }
    }
}

extension MapController {
    
    func configureService() {
        filtersToken = FiltersProvider.filters().observe(updateValues(_:))
    }
    
    func updateValues(_ change: ObjectChange) {
        switch change {
        case .change:
            filter()
        default:
            break
        }
    }
    
    func filter() {
        let filters = FiltersProvider.filters()
        var filteredPoints = points
        
        if !filters.bikeStops {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.stops.rawValue })
        }
        
        if !filters.bikeRental {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.rental.rawValue })
        }
        
        if !filters.bikeParking {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.parking.rawValue })
        }
        
        if !filters.bicyclePaths {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.path.rawValue })
        }
        
        if !filters.bikeSharing {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.sharing.rawValue })
        }
        
        if !filters.bikeRepair {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.repair.rawValue })
        }
        
        if !filters.interestPlaces {
            filteredPoints = filteredPoints?.filter({ $0.categoryID ?? "" != Category.interests.rawValue })
        }
        
        filtered = filteredPoints
    }
}
