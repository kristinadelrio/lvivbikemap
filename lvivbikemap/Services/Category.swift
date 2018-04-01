//
//  Category.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import Foundation

enum Category: String {
    
    case sharing = "5abfa2fcf6c9d8220a99a9f9"
    case repair = "5abfa2fcf6c9d8220a99a9fa"
    case rental = "5abfa2fcf6c9d8220a99a9f8" // and store
    case parking = "5abfa2fcf6c9d8220a99a9fe"
    case path = "5abfa2fcf6c9d8220a99a9fd"
    case stops = "5abfa2fcf6c9d8220a99a9fb"
    case interests = "5abfa2fcf6c9d8220a99a9fc"
    
    var icon: UIImage {
        switch self {
        case .sharing:
            return #imageLiteral(resourceName: "bike sharing")
        case .repair:
            return #imageLiteral(resourceName: "repair")
        case .parking:
            return #imageLiteral(resourceName: "parking")
        case .stops:
            return #imageLiteral(resourceName: "usefull stops")
        case .interests:
            return #imageLiteral(resourceName: "places of interest")
        case .rental:
            return #imageLiteral(resourceName: "bike store")
        default:
            return UIImage()
        }
    }
}
