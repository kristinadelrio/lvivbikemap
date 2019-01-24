//
//  Coordinates.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/21/19.
//

import Foundation

typealias Coordinate = Array<Double>

enum Coordinates: Decodable {
    
    enum CoordinatesError: Error {
        case unexpectedValue
    }
    
    case coordinates([Coordinate])
    
    init(from decoder: Decoder) throws {
        if let coordinate = try? decoder.singleValueContainer()
            .decode(Coordinate.self) {
            self = .coordinates([coordinate])
            
        } else if let polygon = try? decoder.singleValueContainer()
            .decode(Array<Coordinate>.self) {
            self = .coordinates(polygon)
            
        } else {
            throw CoordinatesError.unexpectedValue
        }
    }
    
    var values: [Coordinate]? {
        guard case let .coordinates(coordinates) = self else {
            return nil
        }
        return coordinates
    }
}
