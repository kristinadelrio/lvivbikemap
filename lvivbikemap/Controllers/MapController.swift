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
    
    var points: [Point]? {
        didSet {
            guard let points = points else { return }
            DispatchQueue.main.async {
                for point in points {
                    let position = CLLocationCoordinate2D(
                        latitude: point.feature?.geametry?.coordinate[0] ?? 0,
                        longitude: point.feature?.geametry?.coordinate[1] ?? 0)
                    
                    let marker = GMSMarker()
                    marker.position = position
                    marker.appearAnimation = .none
                    marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                    marker.title = point.feature?.properties?.name ?? "Temp"
                    marker.map = self.mapView
                }
            }
        }
    }
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        configureUI()
        requestUserLocation()
        addMenuBarButtonItem()
        MapService.shared.getPoints { [weak self] (err, points) in
            self?.points = points
        }
    }
    
    func configureUI() {
        
    }
    
    func initialSetup() {
         manager.delegate = self
    }
    
    func requestUserLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
}


extension MapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!,
                                              longitude:(location?.coordinate.longitude)!, zoom:14)
        mapView.animate(to: camera)
        
        self.manager.stopUpdatingLocation()
        
        
    }
}
