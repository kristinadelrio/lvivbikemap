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
    var points: [MapObject]? = nil {
        didSet {
            filter()
        }
    }
    
    var filtered: [MapObject]? = nil {
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
            buckets: [10, 25, 50, 100, 200], backgroundColors: ThemeScheme.clasterColors)
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
        MapObjectsService().get { [weak self] (err, objects) in
            self?.points = objects
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
                let lat = $0.feature?.geometry?.coordinates?.values?.first?[1] ?? 0
                let long = $0.feature?.geometry?.coordinates?.values?.first?[0] ?? 0
                let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let name = $0.feature?.properties?.name ?? ""
                
                let item = ClusterPoint(position: position,
                                        name: name,
                                        image: CategoryMapper.get(for:$0.feature?.properties?.category?.id ?? "") ?? UIImage())
   
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
            let mark = GMSMarker()
            mark.icon = obj.image
            mark.title = obj.name
            mark.position = obj.position
            
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
        filtersToken = FiltersMediator.filters.observe(updateValues(_:))
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
        filtered = points?.filter({
            FiltersService.getActive().map({
                FiltersService.getCategoryId(for: $0)
            }).contains($0.feature?.properties?.category?.id ?? "")
        })
    }
}
