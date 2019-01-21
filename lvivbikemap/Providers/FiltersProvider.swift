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
            case .bikeRental: filters.bikeRental?.state = value
            case .bikeSharing: filters.bikeSharing?.state = value
            case .bikeRepair: filters.bikeRepair?.state = value
            case .bikeStops: filters.bikeStops?.state = value
            case .interestPlaces: filters.interestPlaces?.state = value
            case .bicyclePaths: filters.bicyclePaths?.state = value
            case .bikeParking: filters.bikeParking?.state = value
            }
        }
    }
}
