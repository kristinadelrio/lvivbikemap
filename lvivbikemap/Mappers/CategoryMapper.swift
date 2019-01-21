//
//  CategoryMapper.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/21/19.
//

import Foundation

class CategoryMapper {
    
    static let kBikeSharing = "5c459aa115770e783678dc27"
    static let kBikeRental = "5c459aa115770e783678dc26"
    static let kBikeParking = "5c459aa115770e783678dc2c"
    static let kBikeStops = "5c459aa115770e783678dc29"
    static let kBikeInterests = "5c459aa115770e783678dc2a"
    static let kRepairAndStore = "5c459aa115770e783678dc28"
    static let kBikePath = "5c459aa115770e783678dc2b"
    
    static func get(for id: String) -> UIImage? {
        switch id {
        case kBikeSharing: return UIImage(named: "bike sharing")
        case kBikeRental: return UIImage(named: "rental")
        case kBikeParking: return UIImage(named: "parking")
        case kBikeStops: return UIImage(named: "usefull stops")
        case kBikeInterests: return UIImage(named: "places of interest")
        case kRepairAndStore: return UIImage(named: "bike store-repair")
        default: return nil
        }
    }
}
