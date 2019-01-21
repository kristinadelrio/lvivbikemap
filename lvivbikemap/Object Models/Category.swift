//
//  Category.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit

enum Categories: String {
    
    case sharing = "5c404c42b6096e16498a4a06"
    case repair = "5c404c42b6096e16498a4a07" // and store
    case rental = "5c404c42b6096e16498a4a05"
    case parking = "5c404c42b6096e16498a4a0b"
    case path = "5c404c42b6096e16498a4a0a"
    case stops = "5c404c42b6096e16498a4a08"
    case interests = "5c404c42b6096e16498a4a09"

    var icon: UIImage? {
        switch self {
        case .sharing: return UIImage(named: "bike sharing")
        case .repair: return UIImage(named: "repair")
        case .parking: return UIImage(named: "parking")
        case .stops: return UIImage(named: "usefull stops")
        case .interests: return UIImage(named: "places of interest")
        case .rental: return UIImage(named: "bike store")
        case .path: return nil
        }
    }
}
