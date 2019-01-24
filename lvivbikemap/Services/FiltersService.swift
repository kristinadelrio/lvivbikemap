//
//  FiltersService.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/24/19.
//

import Foundation

typealias FilterStateTuple = Zip2Sequence<[Bool], [Filter]>

class FiltersService {
    
    /// Returns current active filters in Realm
    ///
    /// - Returns: active filters
    static func getActive() -> [Filter] {
        return filterStateTuple.compactMap({ $0.0 ? $0.1 : nil })
    }
    
    /// Returns mapped category id for specific filter
    ///
    /// - Parameter filter: specific Filter for map objects
    /// - Returns: mapped category id for specific filter
    static func getCategoryId(for filter: Filter) -> String {
        switch filter {
        case .bikeRental: return CategoriesMediator.categories.rental
        case .bikeSharing: return CategoriesMediator.categories.sharing
        case .bikeRepair: return CategoriesMediator.categories.repair
        case .bikeStops: return CategoriesMediator.categories.stops
        case .interestPlaces: return CategoriesMediator.categories.interestPlaces
        case .bicyclePaths: return CategoriesMediator.categories.paths
        case .bikeParking: return CategoriesMediator.categories.parking
        }
    }
    
    /// Creates tuple with state saved in the Realm and Filter specificator
    /// Be aware if you perform some changes in one array
    /// you must do the same one in the second
    static private var filterStateTuple: FilterStateTuple {
        let allFilters = FiltersMediator.filters
        return zip(
            [allFilters.bicyclePaths, allFilters.bikeParking, allFilters.bikeRental, allFilters.bikeRepair, allFilters.bikeSharing, allFilters.bikeStops, allFilters.interestPlaces],
            
            [Filter.bicyclePaths, Filter.bikeParking, Filter.bikeRental, Filter.bikeRepair, Filter.bikeSharing, Filter.bikeStops, Filter.interestPlaces])
    }
}
