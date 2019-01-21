//
//  FilterModel.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation
import RealmSwift

class FilterModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var state: Bool = false
    
    convenience init(id: String, state: Bool) {
        self.init()
        self.id = id
        self.state = state
    }
}

class FiltersModel: Object {
    
    @objc dynamic var bikeRental: FilterModel! = FilterModel(id: CategoryMapper.kBikeRental, state: true)
    @objc dynamic var bikeSharing: FilterModel! = FilterModel(id: CategoryMapper.kBikeSharing, state: true)
    @objc dynamic var bikeRepair: FilterModel! = FilterModel(id: CategoryMapper.kRepairAndStore, state: true)
    @objc dynamic var bikeStops: FilterModel! = FilterModel(id: CategoryMapper.kBikeStops, state: true)
    @objc dynamic var interestPlaces: FilterModel! = FilterModel(id: CategoryMapper.kBikeInterests, state: true)
    @objc dynamic var bicyclePaths: FilterModel! = FilterModel(id: CategoryMapper.kBikePath, state: true)
    @objc dynamic var bikeParking: FilterModel! = FilterModel(id: CategoryMapper.kBikeParking, state: true)
    
    var array: [FilterModel] {
        return [bicyclePaths, bikeParking, bikeRental, bikeRepair, bikeSharing, bikeStops, interestPlaces]
    }
}

