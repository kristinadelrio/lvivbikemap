//
//  ApiUrlService.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/21/19.
//

import Foundation

class ApiUrlService {
    
    static let shared = ApiUrlService()
    
    private enum Components: String {
        case host = "http://localhost:3000/api/"
        case points
        case categories
    }
    
    /// Returns url for getting map objects
    var objectsUrl: String {
        return Components.host.rawValue + Components.points.rawValue
    }
    
    /// Returns url for getting categories unique ids
    var categoriesUrl: String {
        return Components.host.rawValue + Components.categories.rawValue
    }
}
