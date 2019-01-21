//
//  MapServicce.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation
import Alamofire

enum MapServiceError: Error {
    case emptyDataError
}

class MapService {
    
    private static var urlStr = "http://localhost:3000/api/points"
    
    static func getPoints(complition: @escaping (Error?, [Point]?)->()) {
        Alamofire.request(urlStr, method: .get).responseJSON { response in
            if let err = response.error {
                complition(err, nil)
                
            } else if let data = response.data {
                do {
                    let points = try JSONDecoder().decode(Array<Point>.self, from: data)
                    complition(nil, points)
                } catch let err {
                    print(err)
                }
            } else {
                complition(MapServiceError.emptyDataError, nil)
            }
        }
    }
}

