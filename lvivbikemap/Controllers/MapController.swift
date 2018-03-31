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
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        configureUI()
        requestUserLocation()
    }
    
    func configureUI() {
        
    }
    
    func initialSetup() {
         manager.delegate = self
    }
    
    func requestUserLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
    }
}


extension MapController: CLLocationManagerDelegate {
    
}
