//
//  FilterModel.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import RealmSwift

class FiltersModel: Object {
    
    @objc dynamic var bikeRental = true
    @objc dynamic var bikeSharing = true
    @objc dynamic var bikeRepair = true
    @objc dynamic var bikeStops = true
    @objc dynamic var interestPlaces = true
    @objc dynamic var bicyclePaths = true
    @objc dynamic var bikeParking = true
}

