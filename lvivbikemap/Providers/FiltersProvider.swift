//
//  File.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation

class FiltersProvider {
    
    private static let mediator = RealmObjectAdapter<FiltersModel>()

    static func filters() -> FiltersModel {
        if let settings = mediator.objects()?.first {
            return settings
        }
        
        do {
            return try create()
        } catch let error {
            fatalError("\(error as NSError)")
        }
    }

    private static func create() throws -> FiltersModel {
        try RealmService.removeAll(of: FiltersModel.self)
        return try mediator.create()
    }

    static func update(filter: Filter, value: Bool) {
        let filters = self.filters()
        
        try? RealmService.write {
            switch filter {
            case .bikeRental: filters.bikeRental = value
            case .bikeSharing: filters.bikeSharing = value
            case .bikeRepair: filters.bikeRepair = value
            case .bikeStops: filters.bikeStops = value
            case .interestPlaces: filters.interestPlaces = value
            case .bicyclePaths: filters.bicyclePaths = value
            case .bikeParking: filters.bikeParking = value
            }
        }
    }
}
