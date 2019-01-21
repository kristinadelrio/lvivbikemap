//
//  Point.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/21/19.
//

import Foundation

struct Point: Decodable {

    let id: String?
    let feature: Feature?
    let version: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version = "__v"
        case feature
    }
}

struct Feature: Decodable {
    var type: String
    var geometry: Geometry?
    var properties: Properties?
}

struct Geometry: Decodable {
    var type: String?
    var coordinates: Coordinates?
}

struct Properties: Decodable {
    var name: String?
    var description: String?
    var category: Category?
}

struct Category: Decodable {
    var id: String?
    var name: String?
}

