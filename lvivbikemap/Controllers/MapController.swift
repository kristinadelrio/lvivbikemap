//
//  MapController.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIButton!
    
    let manager = CLLocationManager()
    var points: [Point]? = nil {
        didSet {
            addMarkers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        requestUserLocation()
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
    
    /// Adds places markers on the map
    private func addMarkers() {
        DispatchQueue.main.async {
            self.points?.forEach({
                let lat = $0.feature?.geametry?.coordinate[1] ?? 0
                let long = $0.feature?.geametry?.coordinate[0] ?? 0
                let position = CLLocationCoordinate2D(latitude: lat, longitude: long)

                let marker = GMSMarker()
                marker.position = position
                marker.appearAnimation = .none
                marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                marker.title = $0.feature?.properties?.name ?? ""
                marker.map = self.mapView
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
