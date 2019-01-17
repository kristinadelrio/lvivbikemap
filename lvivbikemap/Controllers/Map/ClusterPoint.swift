//
//  ClusterPoint.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import Foundation
import GoogleMaps

class ClusterPoint: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    var image: UIImage!
    
    init(position: CLLocationCoordinate2D, name: String, image: UIImage? = nil) {
        self.position = position
        self.name = name
        self.image = image
    }
}
