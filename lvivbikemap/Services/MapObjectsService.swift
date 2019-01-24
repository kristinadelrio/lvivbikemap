//
//  MapServicce.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Alamofire

enum MapServiceError: Error {
    case emptyDataError
    case invalidJSONStructure
}

class MapObjectsService {
    
    typealias MapObjectCompletionHandler = (Error?, [MapObject]?) -> Void
    
    /// Provides map objects array of type 'MapObject'
    ///
    /// - Parameter complition: closure that returns data or error
    func get(_ complition: @escaping MapObjectCompletionHandler) {
        Alamofire.request(ApiUrlService.shared.objectsUrl, method: .get).responseJSON { response in
            if let serverError = response.error {
                complition(serverError, nil)
                
            } else if let data = response.data {
                do {
                    let objects = try JSONDecoder().decode(Array<MapObject>.self, from: data)
                    complition(nil, objects)
                } catch {
                    complition(MapServiceError.invalidJSONStructure, nil)
                }
                
            } else {
                complition(MapServiceError.emptyDataError, nil)
            }
        }
    }
}
