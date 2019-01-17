//
//  FilterModel.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation
import RealmSwift

class FiltersModel: Object {
    
    @objc dynamic var bikeRental: Bool = true
    @objc dynamic var bikeSharing: Bool = true
    @objc dynamic var bikeRepair: Bool = true
    @objc dynamic var bikeStops: Bool = true
    @objc dynamic var interestPlaces: Bool = true
    @objc dynamic var bicyclePaths: Bool = true
    @objc dynamic var bikeParking: Bool = true
}

