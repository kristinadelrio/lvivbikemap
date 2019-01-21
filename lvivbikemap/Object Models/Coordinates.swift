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
        case missingValue
    }
    
    case coordinate(Coordinate)
    case polygon([Coordinate])
    
    init(from decoder: Decoder) throws {
        if let coordinate = try? decoder.singleValueContainer().decode(Coordinate.self) {
            self = .coordinate(coordinate)
            return
        }
        
        if let polygon = try? decoder.singleValueContainer().decode(Array<Coordinate>.self) {
            self = .polygon(polygon)
            return
        }
        
        throw CoordinatesError.missingValue
    }
    
    var values: [[Double]]? {
        switch self {
        case .coordinate(let coordinate): return [coordinate]
        case .polygon(let polygon): return polygon
        }
    }
}
