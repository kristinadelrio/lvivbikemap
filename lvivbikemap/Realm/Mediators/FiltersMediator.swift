//
//  File.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation

class FiltersMediator {
    
    private static let mediator = RealmObjectAdapter<FiltersModel>()

    /// Returns filters model from the realm database
    static var filters: FiltersModel {
        guard let filters = mediator.objects()?.first else {
            do {
                return try create()
            } catch let error {
                fatalError("\(error as NSError)")
            }
        }
        
        return filters
    }
    
    /// Updated particular filter inside the FilterModel
    ///
    /// - Parameters:
    ///   - filter: particular filter that needs updating the state
    ///   - value: new state of the filter
    static func update(filter: Filter, value: Bool) {
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

    /// Creates FiltersModel from scratch
    ///
    /// - Returns: new FiltersModel
    private static func create() throws -> FiltersModel {
        try RealmService.removeAll(of: FiltersModel.self)
        return try mediator.create()
    }
}
