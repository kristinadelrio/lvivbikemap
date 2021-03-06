//
//  MapServicce.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation
import CoreLocation
import Alamofire

struct Geometry {
    var type: String?
    var coordinate: [Double]
}

struct Properties {
    var name: String?
}

struct Feature {
    
    var geametry: Geometry?
    var properties: Properties?
}

struct Point {
    
    let id: String?
    let feature: Feature?
    let version: String?
    let categoryID: String?
}

class MapService {
    
    static var shared = MapService()
    private var urlStr = "http://localhost:4200/api/points"

    func getPoints(complition: @escaping (Error?, [Point]?)->()) {
        Alamofire.request(urlStr, method: .get).responseJSON { response in
            if let err = response.error {
                print("\(err)")
                complition(err, nil)
            }
            
            if let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject {

                if let arr = json as? [AnyObject] {
                    var points = [Point]()
                    for row in arr {
                        let id = row.value(forKeyPath: "_id") as? String
                        let version = row.value(forKeyPath: "__v") as? String
                        let prop = Properties(name: row.value(forKeyPath: "feature.properties.name") as? String)
                        let geo = Geometry(type: row.value(forKeyPath: "feature.geometry.type") as? String,
                                           coordinate: row.value(forKeyPath: "feature.geometry.coordinates") as? [Double] ?? [0, 0])
                        let feature = Feature(geametry: geo, properties: prop)
                        let categoryID = row.value(forKeyPath: "feature.properties.category.id") as? String
                        let point = Point(id: id, feature: feature, version: version, categoryID: categoryID)
                        points.append(point)

                    }
                    complition(nil, points)
                }
            }
        }
    }
}

